#!/bin/bash

start=$1

curl -s "https://www.wunderground.com/history/airport/LRIA/${1}/CustomHistory.html?dayend=$(date +%d)&monthend=$(date +%m)&yearend=$(date +%Y)&req_city=&req_state=&req_statename=&reqdb.zip=&reqdb.magic=&reqdb.wmo=&format=1"|awk -F ',' '{ print $1,"\t",$2,"\t",$3,"\t",$4,"\t",$17,"\t",$18 }'
