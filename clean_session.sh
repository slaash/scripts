#!/bin/bash
#kills all current user's processes except current process and parrent process

pid=$$

echo "Processes before cleanup"
ps --no-heading ux -u slash
#/bin/kill -9 `ps -u ccm_root -o "pid="`
#do not kill terminal sessions
/bin/kill -9 `ps --no-heading -u $USER | egrep -v "$$|csh|bash|sshd" | awk '{ print $1 }'`
echo "Processes after cleanup"
ps --no-heading ux -u slash

