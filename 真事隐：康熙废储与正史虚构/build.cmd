@echo off
setlocal
cd /d "%~dp0"
if not exist build\chapters mkdir build\chapters
where xelatex >nul 2>nul
if errorlevel 1 (
  echo XeLaTeX is not on PATH.
  exit /b 1
)
for %%P in (1 2 3) do (
  xelatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
  if errorlevel 1 exit /b 1
)
copy /y build\main.pdf "真事隐-B5.pdf" >nul
endlocal
