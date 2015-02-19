#!/usr/bin/perl

use strict;
use warnings;

open FILE,"file.txt";
my $cnt=<FILE>;
close FILE;

print $cnt;

