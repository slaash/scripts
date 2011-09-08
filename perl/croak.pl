#!/usr/bin/perl

use warnings;
use strict;

use Carp;

open FILE,"/dev/zro" or croak "$!";
close FILE;

