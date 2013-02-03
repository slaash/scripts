#!/bin/bash

c="md5"

cmd="openssl speed"

for m in 1 2 10 100
do
	echo $m
	echo "encrypt"	
	$cmd -multi $m $c 2>/dev/null|grep -E "^$c"
	echo "decrypt"
	$cmd -decrypt -multi $m $c 2>/dev/null|grep -E "^$c"
done

