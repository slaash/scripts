#!/bin/bash

#cmd=$(ps aux)
cmd="ps -ef"

pscr='chomp $_;if ($_ =~ /^'$USER'\s+(\d+)\s+(\d+).+\d+:\d+\s+(.+)/){print "$$: $1 $2 $3\n";}'
#pscr='chomp $_;print "a: $_\n";'
pscr2='$lines{$_}=1;'

perl -nw -e "$pscr" -e "$pscr2" < <($cmd)

