#!/usr/bin/perl

use strict;
use warnings;
use IPC::Run3;

my $out;
run3(['echo', 'dsa"dsa`'], \undef, \$out);
print $out;

