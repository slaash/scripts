#!/bin/bash

lock_file="/tmp/user_db_backup"
lockfile-check ${lock_file}
if [[ $? == 0 ]]; then
    echo "Lock file exists, exiting"
    exit
fi
lockfile-create -r 0 ${lock_file}
echo "Do work..."
sleep 10
lockfile-remove ${lock_file}
echo "Removed lock file ${lock_file}"

