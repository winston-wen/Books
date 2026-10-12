#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
if [ -x /mnt/c/texlive/2026/bin/windows/xelatex.exe ]; then
  texcmd=/mnt/c/texlive/2026/bin/windows/xelatex.exe
elif command -v xelatex >/dev/null 2>&1 && kpsewhich xeCJK.sty >/dev/null 2>&1; then
  texcmd=xelatex
else
  echo 'XeLaTeX with xeCJK is required.' >&2
  exit 1
fi
mkdir -p build
entries=(main)
if [[ "${1:-}" == '--reference' ]]; then
  entries+=(reference)
elif [[ $# -gt 0 ]]; then
  echo 'Usage: ./build.sh [--reference]' >&2
  exit 2
fi
for entry in "${entries[@]}"; do
  for pass in 1 2 3; do
    "$texcmd" -interaction=nonstopmode -halt-on-error -output-directory=build "$entry.tex" > "build/$entry-pass-$pass.txt" 2>&1 || { tail -45 "build/$entry-pass-$pass.txt"; exit 1; }
  done
done
cp build/main.pdf 康熙的红票-B5重排.pdf
if [[ "${1:-}" == '--reference' ]]; then cp build/reference.pdf 康熙的红票-扫描对照.pdf; fi
echo 'LaTeX build completed.'
