#!/bin/bash

SOLR_DATA_PATH="/tmp"

total="$(df --sync --output=size -B G ${SOLR_DATA_PATH}|tr -d ' '|tail -1|tr -d 'G')"
avail="$(df --sync --output=avail -B G ${SOLR_DATA_PATH}|tr -d ' '|tail -1|tr -d 'G')"

echo "${avail}/${total} GB available."

if (( avail>=total/3 )); then
    echo "OK!"
else
    echo "No enough disk space."
fi
