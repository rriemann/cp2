#!/usr/bin/gnuplot
# kate: encoding utf8
set terminal png lw 2 size 800, 800
set size ratio 1
#set encoding utf8
set grid xtics mytics ytics
set key box
set key left top
#set mxtics 5
#set mytics 5
#set logscale x
#set logscale y
set pointsize 1
set xlabel "B"
#set xrange [20:100]

#L S P (column names)
#1 2 3 (column indexes)

set ylabel "M/V"
set output "../tmp/mv_1.png"
plot 'output_c1.txt' using 1:2 w lp t "M/V"

set ylabel "E/V"
set output "../tmp/ev_1.png"
plot 'output_c1.txt' using 1:3 w lp t "E/V"

set ylabel "M/V"
set output "../tmp/mv_2.png"
plot 'output_c2.txt' using 1:2 w lp t "M/V"

set ylabel "E/V"
set output "../tmp/ev_2.png"
plot 'output_c2.txt' using 1:3 w lp t "E/V"