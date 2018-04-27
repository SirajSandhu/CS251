#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set xlabel "Number of Inputs"
set ylabel "Time"
set yrange[1:]
set xrange[1:]
set ytic auto
set xtic auto

set logscale x
set logscale y
set key bottom right

set output "lineplot.eps"
plot 'lindata/line_final.out' using 1:2 title "1" with linespoints pt 5 lc 8, \
     '' using 1:3 title "2" with linespoints pt 5 lc 6,\
     '' using 1:4 title "4" with linespoints pt 5 lc 1,\
     '' using 1:5 title "8" with linespoints pt 5 lc 4,\
     '' using 1:6 title "16" with linespoints lc 3

set key top right
