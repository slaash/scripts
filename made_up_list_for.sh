#!/bin/bash

list=( 1 2 3 )

#for i in "$( 1 2 3 )"; do
for i in ${list[*]}; do
	echo $i
done

