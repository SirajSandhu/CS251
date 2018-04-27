#!/bin/bash

if [ -d "output" ]
then
    rm -rf "output"
fi

mkdir output
mkdir output/1
mkdir output/2
mkdir output/4
mkdir output/8
mkdir output/16

for param in $(cat params.txt)
do
    for thread in $(cat threads.txt)
    do
        counter=1
        while [ $counter -le 100 ]
        do
            var=$(./App $param $thread)
            arr=($var)
            $(echo ${arr[3]} >> output/$thread/$param)
            ((counter++))
        done
    done
done
