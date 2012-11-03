#!/bin/bash

/etc/init.d/Synergy stop
sleep 10
echo "Processes after Synergy stop"
ps aux
#/bin/kill -9 `ps -u ccm_root -o "pid="`
#do not kill terminal sessions
/bin/kill -9 `ps --no-heading -u ccm_root | egrep -v "csh|sshd" | awk '{ print $1 }'`
echo "Processes before Synergy start"
ps aux
/etc/init.d/Synergy start

