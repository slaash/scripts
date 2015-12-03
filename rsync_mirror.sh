#!/bin/bash

rsync --list-only --dry-run --archive --verbose --delete --delete-delay --delay-updates archive.raspbian.org::archive/raspbian ./

rsync --list-only --dry-run --archive --verbose --delete --delete-delay --delay-updates archive.raspbian.org::archive/raspbian ./|grep "\-\-"|tr -s ' ' |cut -d ' ' -f 2|tr -d ','|paste -sd+ - | bc

