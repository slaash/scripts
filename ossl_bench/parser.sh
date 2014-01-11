#!/bin/bash

if [[ -d $1 ]]; then
	dir=${1%/}
else
	echo "usage: parser.sh <host files dir>"
	exit
fi

regex="^([-\.a-z0-9]+)\s+([0-9]+)\s+(blowfish cbc|rsa 4096 bits)\s+(.+)"
#regex="^([-\.a-z0-9]+)\s+([0-9]+)\s+(blowfish cbc)\s+(.+)"

declare -A hD1
declare -A hD2
declare -A hD10
declare -A hD100

for f in $(ls ${dir}/*.txt); do
#	echo "got file: ${f}"
	while read line; do
		if [[ $line =~ $regex ]]; then
			host=${BASH_REMATCH[1]}
			runs=${BASH_REMATCH[2]}
#			cipher=${BASH_REMATCH[3]}
			data=${BASH_REMATCH[4]}
			if [[ ${runs} == 1 ]]; then
				hD1["${data}"]="${host}"
			elif [[ ${runs} == 2 ]]; then
				hD2["${data}"]="${host}"
			elif [[ ${runs} == 10 ]]; then
				hD10["${data}"]="${host}"
			elif [[ ${runs} == 100 ]]; then
				hD100["${data}"]="${host}"
			fi
#			echo "${host}-${runs}-${cipher}-${data}"
		fi
	done < "${f}"
done

echo "--- 1 ---"
for h in "${!hD1[@]}"; do
	echo "${h} ${hD1[${h}]}"
done | sort -n -k 3
echo "--- 2 ---"
for h in "${!hD2[@]}"; do
	echo "${h} ${hD2[${h}]}"
done | sort -n -k 3
echo "--- 10 ---"
for h in "${!hD10[@]}"; do
	echo "${h} ${hD10[${h}]}"
done | sort -n -k 3
echo "--- 100 ---"
for h in "${!hD100[@]}"; do
	echo "${h} ${hD100[${h}]}"
done | sort -n -k 3

