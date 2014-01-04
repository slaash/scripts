#!/usr/bin/env bash

#export TMPDIR="/tmp"
#tmpf=$(mktemp -t "tmpXXX")
ossl=$(which openssl)
tmpf=()
blowf=()
rsaf=()
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
		while read line; do
			tmpf=("${tmpf[@]}" "${line}")
		done < <(${ossl} speed -multi ${n} ${c} 2>/dev/null)
	done
done

cntb=0
cntr=0
for line in "${tmpf[@]}"; do
	if [[ $line =~ ^blowfish ]]; then
		blowf=("${blowf[@]}" "${host}   ${runs[${cntb}]}        ${line}")
		(( cntb+=1 ))
	elif [[ $line =~ ^rsa\ 4096 ]];then
		rsaf=("${rsaf[@]}" "${host}   ${runs[${cntr}]}        ${line}")
		(( cntr+=1 ))
	fi
done

for i in "${blowf[@]}"; do
	echo "${i}"
done
for i in "${rsaf[@]}"; do
        echo "${i}"
done

if [[ -f /proc/$$/status ]]; then
	cat /proc/$$/status
fi
ps -o user,pid,rss,vsz,args -p $$

