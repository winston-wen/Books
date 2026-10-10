#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "$0")"
mkdir -p build
entry="${1:-main}"
xelatex -interaction=nonstopmode -halt-on-error -output-directory=build "$entry.tex"
xelatex -interaction=nonstopmode -halt-on-error -output-directory=build "$entry.tex"
if [[ "$entry" == main ]]; then cp -- build/main.pdf Fraleigh-retypeset.pdf; fi
