param([switch]$Reference)
$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
$tex = (Get-Command xelatex.exe -ErrorAction SilentlyContinue).Source
if (-not $tex -and (Test-Path -LiteralPath 'C:\texlive\2026\bin\windows\xelatex.exe')) { $tex = 'C:\texlive\2026\bin\windows\xelatex.exe' }
if (-not $tex) { throw 'XeLaTeX is required.' }
New-Item -ItemType Directory -Path 'build' -Force | Out-Null
$entries = @('main')
if ($Reference) { $entries += 'reference' }
foreach ($entry in $entries) {
    foreach ($pass in 1..3) {
        & $tex -interaction=nonstopmode -halt-on-error -output-directory=build "$entry.tex" > "build/$entry-pass-$pass.txt"
        if ($LASTEXITCODE -ne 0) { Get-Content -LiteralPath "build/$entry-pass-$pass.txt" -Tail 45; throw "$entry compilation failed." }
    }
}
Copy-Item -LiteralPath 'build/main.pdf' -Destination '康熙的红票-B5重排.pdf' -Force
if ($Reference) { Copy-Item -LiteralPath 'build/reference.pdf' -Destination '康熙的红票-扫描对照.pdf' -Force }
Write-Host 'B5 LaTeX build completed.'
