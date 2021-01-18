#!/usr/bin/env perl
$latex = 'uplatex %O -kanji=utf8 -synctex=1 %S';
$pdflatex = 'pdflatex %O -kanji=utf8 -synctex=1 %S';
$lualatex = 'lualatex %O -kanji=utf8 -synctex=1 %S';
$xelatex = 'xelatex %O -kanji=utf8 -synctex=1 %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf = 'ps2pdf %O %S %D';
$pdf_mode = 3;
