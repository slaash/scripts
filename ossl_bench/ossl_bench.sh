#!/usr/bin/env bash

export TMPDIR="/tmp"
ossl=$(which openssl)
tmpf=$(mktemp -t "tmpXXX")
blowf=$(mktemp -t "tmpXXX")
rsaf=$(mktemp -t "tmpXXX")
host=$(uname -n)
os=$(uname -s)
arch=$(uname -m)
ciphers="blowfish rsa4096"
runs="1 2"

if [[ -f /proc/meminfo && -f /proc/cpuinfo ]]; then
        mem=$(sed -En "s/MemTotal:\s+(.+)/\1/p" /proc/meminfo)
        cpu=$(sed -En "s/model name\s+:\s+(.+)/\1/p" /proc/cpuinfo)
fi
echo "${host} ${os} ${arch} ${cpu} ${mem}"

for n in ${runs[@]}; do
	for c in ${ciphers};do
		${ossl} speed -multi ${n} ${c} >> ${tmpf} 2>/dev/null
	done
done

while read line; do
	if [[ $line =~ ^blowfish ]]; then
		echo "${host}	${line}">>${blowf}
	elif [[ $line =~ ^rsa\ 4096 ]];then
		echo "${host}	${line}">>${rsaf}
	fi
done < ${tmpf}

cat ${blowf} ${rsaf}

rm ${tmpf} ${blowf} ${rsaf}

