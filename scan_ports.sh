#!/usr/bin/env bash
#sqlite> .schema
#CREATE TABLE ports(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, folder TEXT);

trap ctrl_c INT

function ctrl_c() {
	echo "Goodbye!"
	pkill -f scan_ports.sh
}

dbf=~/ports.sqlite3

find /usr/ports -maxdepth 2 -type d|while read line; do
    folder=$(echo "${line}"|cut -d '/' -f 4,5)
    name=$(echo "${line}"|cut -d '/' -f 5)
    if ! [[ ${name} == '' ]]; then
        echo "${name} ${folder}"
        count=$(sqlite3 ${dbf} "select count(id) from ports where name=\"${name}\"")
        if [[ ${count} == 0 ]]; then
            sqlite3 ${dbf} "insert into ports values(NULL, \"${folder}\", \"${name}\")"
        fi
    fi
done

