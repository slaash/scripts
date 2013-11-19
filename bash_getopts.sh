#!/bin/bash

#script.sh -h -u <http://...> -p <port> -v

while getopts "hu:p:v" ARG
do
	case $ARG in
		h)
			echo "help..."
			;;
		u)
			url=$OPTARG
			echo "$url"
			;;
		p)
			port=$OPTARG
			echo "$port"
			;;
		v)	echo "verbose..."
			;;

	esac
done

