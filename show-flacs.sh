#!/bin/bash

find "${1}" -iname "*.flac"|rev|cut -d '/' -f 2-|rev|sort|uniq
