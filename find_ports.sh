#!/usr/bin/env bash

trap ctrl_c INT

function ctrl_c() {
	echo "Goodbye!"
	pkill -f scan_ports.sh
}

dbf=~/ports.sqlite3

search=${1}

sqlite3 ${dbf} "select folder from ports where name like \"%${search}%\""

