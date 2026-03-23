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

# ── Footer 戳记 ──
# 格式: ----\n*[IDFS] ⊢ [GLENZLI] ⊢ [Part XX] ⊢ [chapter-name] ⊢ [hash]*
# hash 基于剥离 footer 后的纯正文内容
stamp_footer() {
  local filepath="$1"
  local dir_basename part_num chapter_name content_hash

  # 从路径推导 Part 编号和章节名
  dir_basename=$(basename "$(dirname "$filepath")")
  # part-02-idfs-macroscopic-theory -> 02
  part_num=$(echo "$dir_basename" | sed -n 's/^part-\([0-9]*\).*/\1/p')
  [[ -z "$part_num" ]] && part_num="XX"
  # 08-type-ii-systems.md -> 08-type-ii-systems
  chapter_name=$(basename "$filepath" .md)

  # 剥离已有 footer（从末尾的 ---- + *[IDFS] ─ 行开始），计算纯内容 hash
  content_hash=$($PYTHON -c "
import re, hashlib, sys
with open(sys.argv[1], 'r', encoding='utf-8') as f:
    text = f.read()
# 剥离末尾的 footer: ----\n*[IDFS]...*\n (allowing trailing whitespace/newlines)
text_clean = re.sub(r'\n*-{3,}\n\*\[IDFS\][^*]*\*\s*$', '', text)
content = text_clean.rstrip('\n') + '\n'
print(hashlib.sha256(content.encode('utf-8')).hexdigest()[:16])
" "$filepath")

  local footer_marker="----"
  local footer_line="*[IDFS] ⊢ [GLENZLI] ⊢ [Part ${part_num}] ⊢ [${chapter_name}] ⊢ [${content_hash}]*"

  # 写回文件：剥离旧 footer + 追加新 footer
  $PYTHON -c "
import re, sys
with open(sys.argv[1], 'r', encoding='utf-8') as f:
    text = f.read()
text_clean = re.sub(r'\n*-{3,}\n\*\[IDFS\][^*]*\*\s*$', '', text)
content = text_clean.rstrip('\n')
footer = sys.argv[2] + '\n' + sys.argv[3] + '\n'
with open(sys.argv[1], 'w', encoding='utf-8') as f:
    f.write(content + '\n\n' + footer)
" "$filepath" "$footer_marker" "$footer_line"
}

# ── 比较文件哈希（忽略 Generated 时间戳行）──
manifest_content_hash() {
  local file="$1"
  [[ -f "$file" ]] || { echo ""; return; }
  # 剥离 Generated 时间戳行后计算哈希，确保只比较实质内容
  $PYTHON -c "
import hashlib, re, sys
with open(sys.argv[1], 'r') as f:
    text = f.read()
text = re.sub(r'^# Generated:.*$', '', text, flags=re.MULTILINE)
print(hashlib.sha256(text.encode()).hexdigest())
" "$file"
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

  # 先对每个 .md 文件戳记 footer
  echo "$files" | while IFS= read -r f; do
    stamp_footer "$f"
  done

  # 保存旧 MANIFEST 的内容哈希（忽略时间戳）
  local old_hash
  old_hash=$(manifest_content_hash "$manifest")

  local tmp_manifest="${manifest}.tmp"
  cat > "$tmp_manifest" <<EOF
# MANIFEST
# Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')
# Directory: $dir

EOF

  echo "$files" | while IFS= read -r f; do
    echo "## $(basename "$f")" >> "$tmp_manifest"
    triple_hash "$f" >> "$tmp_manifest"
    echo "" >> "$tmp_manifest"
  done

  local new_hash
  new_hash=$(manifest_content_hash "$tmp_manifest")

  if [[ "$old_hash" == "$new_hash" && -n "$old_hash" ]]; then
    rm -f "$tmp_manifest"
    info "$(basename "$dir")/MANIFEST.txt 内容未变化，跳过签名"
    return 0
  fi

  mv -f "$tmp_manifest" "$manifest"
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

  local old_hash
  old_hash=$(manifest_content_hash "$root_manifest")

  local tmp_manifest="${root_manifest}.tmp"
  cat > "$tmp_manifest" <<EOF
# ROOT MANIFEST
# Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')
# 以下为各子目录 MANIFEST.txt 的二次哈希校验

EOF

  echo "$manifests" | while IFS= read -r m; do
    echo "## $m" >> "$tmp_manifest"
    triple_hash "$m" >> "$tmp_manifest"
    echo "" >> "$tmp_manifest"
  done

  local new_hash
  new_hash=$(manifest_content_hash "$tmp_manifest")

  if [[ "$old_hash" == "$new_hash" && -n "$old_hash" ]]; then
    rm -f "$tmp_manifest"
    info "根级 MANIFEST.txt 内容未变化，跳过签名"
    return 0
  fi

  mv -f "$tmp_manifest" "$root_manifest"
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
  # 收集目录到数组
  DIRS=()
  while IFS= read -r d; do
    DIRS+=("$d")
  done < <(find . -mindepth 1 -maxdepth 1 -type d ! -name '.*' | sort)
  [[ ${#DIRS[@]} -eq 0 ]] && fail "未找到子目录"

  echo ""
  printf "${BOLD}发现以下目录:${NC}\n"
  echo ""
  for i in "${!DIRS[@]}"; do
    d="${DIRS[$i]}"
    count=$(find "$d" -maxdepth 1 -name '*.md' -type f ! -name 'MANIFEST.*' 2>/dev/null | wc -l | tr -d ' ')
    printf "  ${CYAN}%d.${NC} %-50s ${GREEN}%s 个 .md 文件${NC}\n" "$((i + 1))" "$d" "$count"
  done
  echo ""

  printf "${BOLD}选择要签名的目录 (输入编号，空格分隔，或 all/回车 = 全部，q = 取消):${NC} "
  read -r selection

  case "$selection" in
    [qQ]*) echo "已取消。"; exit 0 ;;
  esac

  SELECTED=()
  if [[ -z "$selection" || "$selection" == "all" ]]; then
    SELECTED=("${DIRS[@]}")
  else
    for idx in $selection; do
      if [[ "$idx" =~ ^[0-9]+$ ]] && (( idx >= 1 && idx <= ${#DIRS[@]} )); then
        SELECTED+=("${DIRS[$((idx - 1))]}")
      else
        warn "忽略无效编号: $idx"
      fi
    done
  fi

  [[ ${#SELECTED[@]} -eq 0 ]] && fail "未选择任何目录"

  echo ""
  info "将签名 ${#SELECTED[@]} 个目录:"
  for d in "${SELECTED[@]}"; do
    printf "  → %s\n" "$d"
  done
  echo ""

  for d in "${SELECTED[@]}"; do
    sign_dir "$d"
  done

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
  # 添加所有变更：footer 修改的 .md + MANIFEST.txt + MANIFEST.bundle
  git add -A . 2>/dev/null
  if git diff --cached --quiet; then
    info "无变更，跳过提交"
  else
    TIMESTAMP=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
    git commit -m "sign: $TIMESTAMP"
    ok "已提交: sign: $TIMESTAMP"
  fi
fi
