#!/usr/bin/perl

use strict;
use warnings;

use File::stat;

use Data::Dumper;

print Dumper stat("$ARGV[0]");

