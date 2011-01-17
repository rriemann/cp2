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
set xrange [20:100]

#L S P
#1 2 3

set ylabel "P_{∞}"
set output "../tmp/p_inf.pdf"
f(x) = m1*x**a1
fit f(x) '../tmp/plot.dat' using 1:3 via m1,a1
plot '../tmp/plot.dat' using 1:3 pt 2 t "P_{∞}", f(x)

set ylabel "S"
set output "../tmp/s.pdf"
f(x) = m2*x**a2
fit f(x) '../tmp/plot.dat' using 1:2 via m2,a2
plot '../tmp/plot.dat' using 1:2 pt 2 t "S", f(x)

print "\nP_{inf}-Fitergebnisse: f(x) = ", m1, "*x^" , a1
print "\nS-Fitergebnisse: f(x) = ", m2, "*x^", a2, "\n"