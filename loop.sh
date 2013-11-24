#!/bin/bash

(( min = $1 ))
(( max = $2 ))

for ((i=min; i<=max; i++)); do
	(( prim=1 ))
	for ((j=2; j<=$( echo "sqrt($i)"|bc); j++ )); do
		if (( i % j == 0 )); then
			(( prim=0 ))
			break
		fi
	done
	if (( prim == 1 )); then
		echo $i
	fi
done

