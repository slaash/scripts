#!/bin/bash

today=$(date +%Y/%m/%d)
echo ${today}

curl -s "https://www.wunderground.com/history/airport/LRIA/${today}/DailyHistory.html?format=1"|cut -d "," -f 1,2

