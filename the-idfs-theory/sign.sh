#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────
# sign.sh — 多重哈希清单生成 + Sigstore 时间戳签名
#
# 用法:
#   ./sign.sh              自动发现子目录，逐目录签名，最后合并校验
#   ./sign.sh <目录>...    对指定目录签名
#
# 生成 (每个目录内):
#   MANIFEST.txt            SHA-256 / SHA-512 / BLAKE2b 三重哈希清单
#   MANIFEST.bundle         Sigstore 签名 (需 cosign)
# 生成 (工作目录):
#   MANIFEST.txt            各子目录 MANIFEST.txt 的二次哈希
#   MANIFEST.bundle         Sigstore 签名 (需 cosign)
# ──────────────────────────────────────────────────────────────
set -euo pipefail

NO_COMMIT=false
ARGS=()
for arg in "$@"; do
  case "$arg" in
    --no-commit) NO_COMMIT=true ;;
    *) ARGS+=("$arg") ;;
  esac
done
set -- "${ARGS[@]+${ARGS[@]}}"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

info()  { printf "${CYAN}[INFO]${NC}  %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${NC}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${NC}  %s\n" "$*"; }
fail()  { printf "${RED}[FAIL]${NC}  %s\n" "$*"; exit 1; }

HAS_COSIGN=false
command -v cosign &>/dev/null && HAS_COSIGN=true

# ── 检查 Python ──
PYTHON=""
for cmd in python3 python; do
  if command -v "$cmd" &>/dev/null; then
    PYTHON="$cmd"
    break
  fi
done
[[ -z "$PYTHON" ]] && fail "需要 Python 3"
$PYTHON -c "import hashlib; hashlib.sha256(); hashlib.sha512(); hashlib.blake2b()" 2>/dev/null \
  || fail "Python hashlib 缺少必要的哈希算法支持"

# ── 计算三重哈希 (输出到 stdout) ──
triple_hash() {
  $PYTHON -c "
import hashlib, sys
data = open(sys.argv[1], 'rb').read()
print(f'SHA-256:  {hashlib.sha256(data).hexdigest()}')
print(f'SHA-512:  {hashlib.sha512(data).hexdigest()}')
print(f'BLAKE2b:  {hashlib.blake2b(data).hexdigest()}')
" "$1"
}

# ── cosign 签名 ──
cosign_sign() {
  local target="$1"
  if $HAS_COSIGN; then
    cosign sign-blob "$target" --bundle "${target%.txt}.bundle"
    ok "$(dirname "$target")/MANIFEST.bundle"
  fi
}

# ── 对单个目录生成 MANIFEST.txt + bundle ──
sign_dir() {
  local dir="$1"
  local manifest="$dir/MANIFEST.txt"

  local files
  files=$(find "$dir" -maxdepth 1 -name '*.md' -type f ! -name 'MANIFEST.*' | sort)
  [[ -z "$files" ]] && { warn "跳过 $dir (无 .md 文件)"; return 1; }

  local count
  count=$(echo "$files" | wc -l | tr -d ' ')
  info "$(basename "$dir")：${count} 个文件"

  cat > "$manifest" <<EOF
# MANIFEST
# Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')
# Directory: $dir

EOF

  echo "$files" | while IFS= read -r f; do
    echo "## $(basename "$f")" >> "$manifest"
    triple_hash "$f" >> "$manifest"
    echo "" >> "$manifest"
  done

  ok "$(basename "$dir")/MANIFEST.txt"
  cosign_sign "$manifest"
}

# ── 生成根级合并 MANIFEST ──
sign_root() {
  local root_manifest="MANIFEST.txt"
  local manifests
  manifests=$(find . -mindepth 2 -maxdepth 2 -name 'MANIFEST.txt' -type f | sort)

  [[ -z "$manifests" ]] && { warn "未找到子目录 MANIFEST.txt，跳过合并"; return; }

  echo ""
  info "生成根级合并校验..."

  cat > "$root_manifest" <<EOF
# ROOT MANIFEST
# Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')
# 以下为各子目录 MANIFEST.txt 的二次哈希校验

EOF

  echo "$manifests" | while IFS= read -r m; do
    echo "## $m" >> "$root_manifest"
    triple_hash "$m" >> "$root_manifest"
    echo "" >> "$root_manifest"
  done

  ok "MANIFEST.txt (根级合并)"
  cosign_sign "$root_manifest"
}

# ── 主逻辑 ──
if [[ $# -ge 1 ]]; then
  for dir in "$@"; do
    [[ -d "$dir" ]] || fail "目录不存在: $dir"
    sign_dir "$dir"
  done
  sign_root
else
  DIRS=$(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' | sort)
  [[ -z "$DIRS" ]] && fail "未找到子目录"

  echo ""
  printf "${BOLD}发现以下目录:${NC}\n"
  echo ""
  i=1
  while IFS= read -r d; do
    count=$(find "$d" -maxdepth 1 -name '*.md' -type f ! -name 'MANIFEST.*' 2>/dev/null | wc -l | tr -d ' ')
    printf "  ${CYAN}%d.${NC} %-50s ${GREEN}%s 个 .md 文件${NC}\n" "$i" "$d" "$count"
    i=$((i + 1))
  done < <(echo "$DIRS")
  echo ""

  printf "${BOLD}生成哈希清单？${NC} [Y/n] "
  read -r confirm
  case "$confirm" in
    [nN]*) echo "已取消。"; exit 0 ;;
  esac

  echo ""
  while IFS= read -r d; do
    sign_dir "$d"
  done < <(echo "$DIRS")

  sign_root
fi

echo ""
if ! $HAS_COSIGN; then
  warn "未安装 cosign — 已跳过 Sigstore 签名"
  info "安装: brew install cosign"
fi
ok "完成 ✓"

# ── 自动提交 ──
if ! $NO_COMMIT && git rev-parse --is-inside-work-tree &>/dev/null; then
  echo ""
  git add -A '*.txt' '*.bundle' -- '**/MANIFEST.txt' '**/MANIFEST.bundle' 'MANIFEST.txt' 'MANIFEST.bundle' 2>/dev/null
  git add MANIFEST.txt MANIFEST.bundle */MANIFEST.txt */MANIFEST.bundle 2>/dev/null || true
  TIMESTAMP=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
  git commit -m "sign: $TIMESTAMP" --allow-empty
  ok "已提交: sign: $TIMESTAMP"
fi
