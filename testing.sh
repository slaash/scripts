#!/bin/bash

arr=(1 2 3 22)

for i in "${arr[@]}"; do
	if [[ "${i}" == 2 ]]; then
		echo "1: ${i}"
	fi

	if [[ "${i}" =~ 2 ]]; then
		echo "2: ${i}"
	fi
done

