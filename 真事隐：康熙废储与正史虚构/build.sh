#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if command -v xelatex >/dev/null 2>&1; then
  texcmd=xelatex
elif [ -x /mnt/c/texlive/2026/bin/windows/xelatex.exe ]; then
  texcmd=/mnt/c/texlive/2026/bin/windows/xelatex.exe
else
  echo '请安装 XeLaTeX 或将其加入 PATH。' >&2
  exit 1
fi
mkdir -p build/chapters
for pass in 1 2 3; do
  "$texcmd" -interaction=nonstopmode -halt-on-error -output-directory=build main.tex > "build/pass-${pass}.txt" 2>&1 || { tail -60 "build/pass-${pass}.txt"; exit 1; }
done
cp build/main.pdf 真事隐-B5.pdf
echo '完成：真事隐-B5.pdf'
