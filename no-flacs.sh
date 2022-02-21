#!/bin/bash

find "${1}" \( -iname "*.mp3" -o -iname "*.m4a" \)|rev|cut -d '/' -f 2-|rev|sort|uniq
