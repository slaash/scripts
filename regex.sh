#!/bin/bash

str="root 1234 5678 ssh localhost 2222"
echo "${str}"

regex="(.+)\s+[0-9]+\s+[0-9]+(.+)"

if [[ $str =~ $regex ]]; then
	for i in "${BASH_REMATCH[@]:1}"; do
		echo ${i}
	done
fi

pregex="^(\w+)\s+.+\s+[0-9]+:[0-9]+\s+(.+)"
while read line; do
	if [[ $line =~ $pregex ]];then
		echo "${BASH_REMATCH[1]} ${BASH_REMATCH[2]}"
	fi
done < <(ps aux)
