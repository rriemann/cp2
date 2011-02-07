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
set xlabel "B"
#set xrange [20:100]

#L S P (column names)
#1 2 3 (column indexes)

set ylabel "M/V"
set output "../tmp/mv.pdf"
plot 'output_c1.txt' using 1:2 pt 2 t "M/V"

set ylabel "E/V"
set output "../tmp/ev.pdf"
plot 'output_c2.txt' using 1:3 pt 2 t "E/V"