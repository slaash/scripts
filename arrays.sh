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

declare -A people
people=([gigi]=11 [vasile]=12)
for i in ${!people[@]}; do
	echo "${i} ${people[${i}]}"
done

