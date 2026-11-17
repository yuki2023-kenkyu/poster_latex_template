# Windows/TeX Live: run from the project root with `latexmk main.tex`.
# latexmk requires Perl; TeX Live for Windows normally supplies it.
$pdf_mode = 4; # LuaLaTeX -> PDF
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$out_dir = 'build';
$max_repeat = 5;
$bibtex_use = 2; # Biblatex's Biber dependency is resolved from main.bcf.
