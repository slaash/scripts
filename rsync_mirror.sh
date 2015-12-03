#!/bin/bash

rsync --list-only --dry-run --archive --verbose --delete --delete-delay --delay-updates archive.raspbian.org::archive/raspbian ./

