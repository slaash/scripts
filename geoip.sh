#!/bin/bash

curl -s http://freegeoip.net/csv/$1|csvtool -u TAB col 1- -

