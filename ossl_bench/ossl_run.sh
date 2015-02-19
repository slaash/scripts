#!/bin/bash

if [ $1 ]; then
	c=$1
else
	c="md5"
fi

cmd=`which openssl`

uname -a
grep "model name" /proc/cpuinfo|uniq -c

for m in 1 2 10 100
do
	echo "encrypt/decrypt - $m procs"
	$cmd speed -multi $m $c 2>/dev/null|grep -E "^$c"
	echo "-"
	$cmd speed -decrypt -multi $m $c 2>/dev/null|grep -E "^$c"
done

