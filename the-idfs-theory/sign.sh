#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────
# sign.sh — 多重哈希清单生成 + Sigstore 时间戳签名
#
# 用法:
#   ./sign.sh              自动发现当前目录下的子目录
#   ./sign.sh <目录>       对指定目录签名
#
# 生成 (每个目录内):
#   MANIFEST.txt            SHA-256 / SHA-512 / BLAKE2b 三重哈希清单
#   MANIFEST.bundle         Sigstore 签名 + 时间戳包 (需 cosign)
# ──────────────────────────────────────────────────────────────
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; BOLD='\033[1m'; NC='\033[0m'

info()  { printf "${CYAN}[INFO]${NC}  %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${NC}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${NC}  %s\n" "$*"; }
fail()  { printf "${RED}[FAIL]${NC}  %s\n" "$*"; exit 1; }

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

# ── 对单个目录生成三重哈希清单 ──
sign_dir() {
  local dir="$1"
  local manifest="$dir/MANIFEST.txt"

  local files
  files=$(find "$dir" -maxdepth 1 -name '*.md' -type f ! -name 'MANIFEST.*' | sort)
  [[ -z "$files" ]] && { warn "跳过 $dir (无 .md 文件)"; return; }

  local count
  count=$(echo "$files" | wc -l | tr -d ' ')
  info "$(basename "$dir")：${count} 个文件"

  cat > "$manifest" <<EOF
# MANIFEST
# Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')
# Directory: $(cd "$dir" && pwd)
#
# 三种哈希，来自三个独立设计谱系:
#   SHA-256   — NIST/NSA，当前工业标准，256-bit
#   SHA-512   — 同族更长位宽，量子 Grover 攻击下仍保持 256-bit 安全等级
#   BLAKE2b   — Bernstein 谱系，与 ChaCha 共享 ARX 核心原语，独立于 NSA 体系
# ──────────────────────────────────────────────────────────────

EOF

  echo "$files" | while IFS= read -r f; do
    echo "## $(basename "$f")" >> "$manifest"
    $PYTHON -c "
import hashlib, sys
data = open(sys.argv[1], 'rb').read()
print(f'SHA-256:  {hashlib.sha256(data).hexdigest()}')
print(f'SHA-512:  {hashlib.sha512(data).hexdigest()}')
print(f'BLAKE2b:  {hashlib.blake2b(data).hexdigest()}')
" "$f" >> "$manifest"
    echo "" >> "$manifest"
  done

  ok "$(basename "$dir")/MANIFEST.txt"

  # Sigstore 签名
  if command -v cosign &>/dev/null; then
    cosign sign-blob "$manifest" --bundle "$dir/MANIFEST.bundle" 2>/dev/null
    ok "$(basename "$dir")/MANIFEST.bundle"
  fi
}

# ── 主逻辑 ──
if [[ $# -ge 1 ]]; then
  # 指定目录模式
  for dir in "$@"; do
    [[ -d "$dir" ]] || fail "目录不存在: $dir"
    sign_dir "$dir"
  done
else
  # 自动发现模式
  DIRS=$(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' ! -name 'old-fragments' | sort)
  [[ -z "$DIRS" ]] && fail "当前目录下未找到子目录"

  echo ""
  printf "${BOLD}发现以下目录:${NC}\n"
  echo ""
  i=1
  echo "$DIRS" | while IFS= read -r d; do
    count=$(find "$d" -maxdepth 1 -name '*.md' -type f ! -name 'MANIFEST.*' 2>/dev/null | wc -l | tr -d ' ')
    printf "  ${CYAN}%d.${NC} %-50s ${GREEN}%s 个 .md 文件${NC}\n" "$i" "$(basename "$d")" "$count"
    i=$((i + 1))
  done
  echo ""

  printf "${BOLD}对以上目录生成哈希清单？${NC} [Y/n] "
  read -r confirm
  case "$confirm" in
    [nN]*) echo "已取消。"; exit 0 ;;
  esac

  echo ""
  echo "$DIRS" | while IFS= read -r d; do
    sign_dir "$d"
  done
fi

# ── 结尾 ──
echo ""
if ! command -v cosign &>/dev/null; then
  warn "未安装 cosign — 已跳过 Sigstore 签名"
  info "安装: brew install cosign"
fi
ok "完成 ✓"
