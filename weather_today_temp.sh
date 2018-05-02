#!/bin/bash

today=$(date +%Y%m%d)
echo ${today}

#curl -s "https://www.wunderground.com/history/airport/LRIA/${today}/DailyHistory.html?format=1"|awk -F ',' '{ print $1,"\t",$2,"\t",$8 }'
curl -s "https://api.wunderground.com/api/c7862614119770b4/history/lang:RO/q/RO/LRIA.json"
