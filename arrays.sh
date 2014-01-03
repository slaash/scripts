#!/bin/bash

runs=(1 2 3)
runs=(${runs[@]} 4)
unset runs[2]

for i in ${runs[@]}; do
	echo ${i}
done

echo ${#runs[@]}
echo ${runs[@]:1:2}

farray=( $(uname -a) )
for i in ${farray[@]}; do
	echo ${i}
done
