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
set xrange [20:100]

#L S P (column names)
#1 2 3 (column indexes)

set ylabel "P_{∞}"
set output "../tmp/p_inf.pdf"
f(x) = m1*x**a1
fit f(x) '../tmp/plot.dat' using 1:3 via m1,a1
plot '../tmp/plot.dat' using 1:3 pt 2 t "P_{∞}", f(x) lt -1

set ylabel "S"
set output "../tmp/s.pdf"
f(x) = m2*x**a2
fit f(x) '../tmp/plot.dat' using 1:2 via m2,a2
plot '../tmp/plot.dat' using 1:2 pt 2 t "S", f(x) lt -1