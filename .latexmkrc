#!/usr/bin/perl
$pdflatex = 'lualatex %O %S';
$bibtex = 'upbibtex %O %B';
$pdf_mode = 1;
$bibtex_use = 2;
$pdf_previewer = 'okular --unique';
@default_excluded_files = ('hiraminpron-w3.luc', 'hirakakupron-w6.luc');
$clean_ext .= '%R.ltjruby %R.nav %R.snm';
