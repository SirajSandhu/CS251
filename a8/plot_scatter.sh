#!/bin/bash

for thread in $(cat threads.txt)
do
    gnuplot -e "infile='scatterdata/scatter_$thread.out'; outfile='scatter_$thread.eps" scatter.p
done
