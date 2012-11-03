#!/usr/bin/perl

use strict;
use warnings;
use IPC::Run3;

my $out;
my $err;

run3(join(' ',@ARGV), \undef, \$out,\$err);
print "STDOUT: $out\n";
print "STDERR: $err\n";
print "EXI CODE: $?\n";

