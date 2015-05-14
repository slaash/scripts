#!/usr/bin/env bash

trap ctrl_c INT

function ctrl_c() {
	echo "Goodbye!"
	pkill -f scan_ports.sh
}

dbf=~/ports.sqlite3

if [[ $# == 1 ]]; then
    #basic package search
    search=${1}
    sqlite3 ${dbf} "select folder from ports where name like \"%${search}%\""
else
    mode=${1}
    search=${2}
    if [[ ${mode} == "all" ]]; then
        #show all packages in group folder
        sqlite3 ${dbf} "select name from ports where folder like \"${search}/%\""
    fi
fi

