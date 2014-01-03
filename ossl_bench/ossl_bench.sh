#!/usr/bin/env bash

export TMPDIR="/tmp"
ossl=$(which openssl)
tmpf=$(mktemp -t "tmpXXX")
blowf=$(mktemp -t "tmpXXX")
rsaf=$(mktemp -t "tmpXXX")
host=$(uname -n)
os=$(uname -s)
arch=$(uname -m)
ciphers=(blowfish rsa4096)
runs=(1 2 10 100)

if [[ -f /proc/meminfo && -f /proc/cpuinfo ]]; then
        mem=$(sed -En "s/MemTotal:\s+(.+)/\1/p" /proc/meminfo)
        cpu=$(sed -En "s/model name\s+:\s+(.+)/\1/p" /proc/cpuinfo | uniq -c)
fi
${ossl} version
echo "${host} ${os} ${arch} ${cpu} ${mem}"

for n in ${runs[@]}; do
	for c in ${ciphers[@]};do
		${ossl} speed -multi ${n} ${c} >> ${tmpf} 2>/dev/null
	done
done

cntb=0
cntr=0
while read line; do
	if [[ $line =~ ^blowfish ]]; then
		echo "${host}	${runs[${cntb}]}	${line}">>${blowf}
		(( cntb+=1 ))
	elif [[ $line =~ ^rsa\ 4096 ]];then
		echo "${host}	${runs[${cntr}]}	${line}">>${rsaf}
		(( cntr+=1 ))
	fi
done < ${tmpf}

cat ${blowf} ${rsaf}

rm ${tmpf} ${blowf} ${rsaf}

