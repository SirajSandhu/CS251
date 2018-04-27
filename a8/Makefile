all:Report

Report: Plots report.tex
	pdflatex report.tex

Plots: lineplot.eps speedup.eps speedup_errorbar.eps scatter_1.eps scatter_2.eps scatter_4.eps scatter_8.eps scatter_16.eps 
	
speedup_errorbar.eps:lindata speedup_plot_error.p
	gnuplot speedup_plot_error.p
speedup.eps:lindata speedup_plot.p
	gnuplot speedup_plot.p
lineplot.eps:lindata lineplot.p
	gnuplot lineplot.p
scatter_1.eps: scatterdata scatter.p
	gnuplot -e "infile='scatterdata/scatter_1.out'; outfile='scatter_1.eps'" scatter.p
scatter_2.eps: scatterdata scatter.p
	gnuplot -e "infile='scatterdata/scatter_2.out'; outfile='scatter_2.eps'" scatter.p
scatter_4.eps: scatterdata scatter.p
	gnuplot -e "infile='scatterdata/scatter_4.out'; outfile='scatter_4.eps'" scatter.p
scatter_8.eps: scatterdata scatter.p
	gnuplot -e "infile='scatterdata/scatter_8.out'; outfile='scatter_8.eps'" scatter.p
scatter_16.eps: scatterdata scatter.p
	gnuplot -e "infile='scatterdata/scatter_16.out'; outfile='scatter_16.eps'" scatter.p

Analyse: lindata scatterdata
lindata: output
	bash lingraph.sh
scatterdata: output
	bash scattergraph.sh

output:App generate.sh params.txt
	bash generate.sh

App:thread_function.o prog.o 
	gcc -o App thread_function.o prog.o -lm -lpthread
prog.o:prog.c common.h
	gcc -c prog.c -o prog.o
thread_function.o:thread_function.c common.h
	gcc -c thread_function.c -o thread_function.o
clean:
	rm -f *.o App *.pdf *.eps texput.log report.pdf report.aux report.log & rm -rf output scatterdata lindata

