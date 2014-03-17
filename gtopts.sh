#!/bin/bash

OPTIND=1
while getopts "c:f:" opt; do
	case "$opt" in
	c)
		cmd=$OPTARG
		;;
	f)	file=$OPTARG
		;;
	esac
done
echo ${cmd}
echo ${file}
shift $(($OPTIND - 1))
echo ${1}
