#!/bin/bash

#for i in "$(ps aux)"; do
#	echo "${i}"
#done

while read line; do
	echo "${line}"
done < <(ps aux)
