#!/bin/bash

if [[ -d $1 ]]; then
	dir=${1%/}
else
	echo "usage: parser.sh <host files dir>"
	exit
fi

regex="^([-\.a-z0-9]+)\s+([0-9]+)\s+(blowfish cbc|rsa 4096 bits)\s+(.+)"
#regex="^([-\.a-z0-9]+)\s+([0-9]+)\s+(blowfish cbc)\s+(.+)"
#mapping_regex="([-\.a-zA-Z0-9]+),([-\.a-zA-Z0-9 ]+)"
mapping_regex="([-\.a-zA-Z0-9]+),(.+)"

declare -A hD1
declare -A hD2
declare -A hD10
declare -A hD100

declare -A mapping

for f in ${dir}/*.txt; do
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

while read l; do
	if [[ $l =~ $mapping_regex ]]; then
		h=${BASH_REMATCH[1]}
		t=${BASH_REMATCH[2]}
#		echo "$h: $t"
		mapping["$h"]="$t"
	fi
done < <(for f in ${dir}/*.txt; do head -2 "${f}"|grep -vE '==|OpenSSL|^$'|tr -s ' '|sed -e 's/ /,/'; done)

echo "--- 1 ---"
for h in "${!hD1[@]}"; do
	echo "${h} ${hD1[${h}]} (${mapping[${hD1[${h}]}]})"
done | sort -n -k 3
echo "--- 2 ---"
for h in "${!hD2[@]}"; do
	echo "${h} ${hD2[${h}]} (${mapping[${hD2[${h}]}]})"
done | sort -n -k 3
echo "--- 10 ---"
for h in "${!hD10[@]}"; do
	echo "${h} ${hD10[${h}]} (${mapping[${hD10[${h}]}]})"
done | sort -n -k 3
echo "--- 100 ---"
for h in "${!hD100[@]}"; do
	echo -e "${h} ${hD100[${h}]} (${mapping[${hD100[${h}]}]})"
done | sort -n -k 3

