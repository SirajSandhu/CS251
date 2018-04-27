#!/bin/bash

if [ -d "lindata" ]
then
    rm -rf lindata
fi
mkdir lindata

touch lindata/line_final.out
for thread in $(cat threads.txt)
do
    #touch scatter.out
    for file in $(ls output/$thread)
    do
        time=0;
        data=$(cat output/$thread/$file)
        for nums in $data
        do
            time=$(( $time + $nums ))
        done
        avg_time=$(( $time / 100 ))
        echo "$avg_time" >> lindata/line_$thread.out

        var=0;
        for nums in $data
        do
            var=$(( $var + ($avg_time - $nums) * ($avg_time - $nums) ))
        done
        var=$(( $var / 100 ))
        echo  sqrt"($var)" | bc >> lindata/line_std_$thread.out
    done
done
for file in $(ls output/1)
do
    echo "$file" >> lindata/num.out
done
paste lindata/num.out lindata/line_1.out lindata/line_2.out lindata/line_4.out lindata/line_8.out lindata/line_16.out lindata/line_std_1.out lindata/line_std_2.out lindata/line_std_4.out lindata/line_std_8.out lindata/line_std_16.out> lindata/line_final.out
