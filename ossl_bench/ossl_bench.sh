#!/bin/bash

ossl=$(which openssl)
tmpf=$(mktemp)
echo "${tmpf}"
ciphers="blowfish rsa4096"
runs="1 2 10 100"

for n in ${runs[@]}; do
	for c in ${ciphers};do
		echo "${c} - ${n}"
		${ossl} speed -multi ${n} ${c} >> ${tmpf} 2>/dev/null
	done
done

host=$(uname -n)
blowf=$(mktemp)
rsaf=$(mktemp)

while read line; do
	if [[ $line =~ ^blowfish ]]; then
		echo "${host}	${line}">>${blowf}
	elif [[ $line =~ ^rsa\ 4096 ]];then
		echo "${host}	${line}">>${rsaf}
	fi
done < ${tmpf}

if [[ $1 ]];then
	cat ${blowf} ${rsaf}>${1}
fi
cat ${blowf} ${rsaf}

rm ${tmpf} ${blowf} ${rsaf}

