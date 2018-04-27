#set terminal postscript eps enhanced color size 3.9,2.9
set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "speedup.eps"

set key font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "Number of Inputs"
set ylabel "Time"
set yrange[1:]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border
set logscale y
plot 'lindata/line_final.out' u 1:xticlabels(1) title "1",\
'' u 2 title "2" fillstyle pattern 7,\
'' u 3 title "4" fillstyle pattern 4,\
'' u 4 title "4" fillstyle pattern 12,\
'' u 5 title "16" fillstyle pattern 14
