#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────
# sign.sh — 多重哈希清单生成 + Sigstore 时间戳签名
# 用法: ./sign.sh [章节目录, 默认当前目录]
#
# 生成:
#   MULTI_HASH_MANIFEST.txt   三重哈希清单
#   MANIFEST.bundle           Sigstore 签名 + 时间戳包 (需 cosign)
# ──────────────────────────────────────────────────────────────
set -euo pipefail

CHAPTER_DIR="${1:-.}"
MANIFEST="MULTI_HASH_MANIFEST.txt"

# ── 颜色 ──
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'

info()  { printf "${CYAN}[INFO]${NC}  %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${NC}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${NC}  %s\n" "$*"; }
fail()  { printf "${RED}[FAIL]${NC}  %s\n" "$*"; exit 1; }

# ── 检查 Python (hashlib 内置 SHA-256/512 + BLAKE2b) ──
PYTHON=""
for cmd in python3 python; do
  if command -v "$cmd" &>/dev/null; then
    PYTHON="$cmd"
    break
  fi
done
[[ -z "$PYTHON" ]] && fail "需要 Python 3 (hashlib 提供全部三种哈希算法)"

# ── 验证 Python hashlib 支持 ──
$PYTHON -c "import hashlib; hashlib.sha256(); hashlib.sha512(); hashlib.blake2b()" 2>/dev/null \
  || fail "Python hashlib 缺少必要的哈希算法支持"

info "Python:     $($PYTHON --version 2>&1)"
info "章节目录:   $(cd "$CHAPTER_DIR" && pwd)"

# ── 收集 markdown 文件 ──
FILES=$(find "$CHAPTER_DIR" -maxdepth 1 -name '*.md' -type f | sort)
[[ -z "$FILES" ]] && fail "未在 $CHAPTER_DIR 中找到任何 .md 文件"

FILE_COUNT=$(echo "$FILES" | wc -l | tr -d ' ')
info "找到 ${FILE_COUNT} 个文件"

# ── 生成三重哈希 ──
cat > "$CHAPTER_DIR/$MANIFEST" <<EOF
# MULTI_HASH_MANIFEST
# Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')
# Directory: $(cd "$CHAPTER_DIR" && pwd)
#
# 三种密码学指纹，来自三个独立设计谱系:
#   SHA-256   — NIST/NSA 设计，当前工业标准，256-bit 安全
#   SHA-512   — 同族更长位宽，量子 Grover 攻击下仍保持 256-bit 安全等级
#   BLAKE2b   — Bernstein 谱系，与 ChaCha 共享 ARX 核心原语，独立于 NSA 体系
# ──────────────────────────────────────────────────────────────

EOF

echo "$FILES" | while IFS= read -r f; do
  bname=$(basename "$f")
  echo "## $bname" >> "$CHAPTER_DIR/$MANIFEST"

  $PYTHON -c "
import hashlib, sys
data = open(sys.argv[1], 'rb').read()
print(f'SHA-256:  {hashlib.sha256(data).hexdigest()}')
print(f'SHA-512:  {hashlib.sha512(data).hexdigest()}')
print(f'BLAKE2b:  {hashlib.blake2b(data).hexdigest()}')
" "$f" >> "$CHAPTER_DIR/$MANIFEST"

  echo "" >> "$CHAPTER_DIR/$MANIFEST"
  ok "$bname"
done

info "清单已生成: $CHAPTER_DIR/$MANIFEST"

# ── Sigstore 签名 ──
if command -v cosign &>/dev/null; then
  info "检测到 cosign，正在签名..."
  cosign sign-blob "$CHAPTER_DIR/$MANIFEST" --bundle "$CHAPTER_DIR/MANIFEST.bundle"
  ok "签名完成: $CHAPTER_DIR/MANIFEST.bundle"
  echo ""
  info "验证命令:"
  echo "  cosign verify-blob $CHAPTER_DIR/$MANIFEST --bundle $CHAPTER_DIR/MANIFEST.bundle --certificate-identity=<your-email> --certificate-oidc-issuer=https://accounts.google.com"
else
  warn "未安装 cosign — 跳过 Sigstore 签名"
  echo ""
  info "安装 cosign:"
  echo "  brew install cosign"
  echo ""
  info "安装后签名:"
  echo "  cosign sign-blob $CHAPTER_DIR/$MANIFEST --bundle $CHAPTER_DIR/MANIFEST.bundle"
fi

echo ""
ok "完成 ✓"
