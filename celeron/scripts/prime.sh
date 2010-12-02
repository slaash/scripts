#!/bin/bash

min=1
max=100
for ((i=$min;i<=$max;i++))
do
    prim=1
    for ((j=2;j<=`echo "sqrt ($i)"|bc`;j++))
    do
	if [ `expr $i % $j` == 0 ]
	then
	    prim=0
	fi
    done
    if [ $prim == 1 ]
    then
	echo "$i"
    fi
done

