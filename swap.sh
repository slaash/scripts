#!/bin/bash
## bash for loop example to list what processes are using swap space##
for file in /proc/*/status
do 
  awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file 
done
