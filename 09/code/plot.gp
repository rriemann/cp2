#!/usr/bin/gnuplot
# kate: encoding utf8
set terminal pdfcairo enhanced solid size 4,4 lw 2
set size ratio 1
set encoding utf8
set grid xtics mytics ytics
set key box
set key right top
set mxtics 5
set mytics 5
set logscale x
set logscale y
set pointsize 1
set xlabel "Gittergröße L"
#set yrange [0:1400]

#L S P
#1 2 3

set ylabel "P_inf"
set output "../tmp/p_inf.pdf"
plot '../tmp/plot.dat' using 1:3 pt 2 t "P_{inf}"

set ylabel "S"
set output "../tmp/s.pdf"
plot '../tmp/plot.dat' using 1:2 pt 2 t "S"

