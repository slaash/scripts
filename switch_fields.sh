#!/bin/bash

cat|awk -F': ' '{print $2,$1}'|sed 's/,/:/g'|sed 's/$/,/g'|tr -s ' '
