#!/bin/bash

if [ -d "scatterdata" ]
then
    rm -rf scatterdata
fi
mkdir scatterdata

for thread in $(cat threads.txt)
do
    #touch scatter.out
    for file in $(ls output/$thread)
    do
        data=$(cat output/$thread/$file)
        for nums in $data
        do
            echo "$file $nums" >> scatterdata/scatter_$thread.out
        #echo $file
        done
    done
    #gnuplot -e "infile='scatterdata/scatter_$thread.out'; outfile='scatterdata/scatter_$thread.eps" scatter.p
done

