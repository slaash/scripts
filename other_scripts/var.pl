#!/usr/bin/perl

use strict;
use warnings;

my @s=("1","2","3");

my %hash;

$hash{"a"}=\@s;

my ($nume,$valori)=each %hash;
for (@$valori){
	print $_;
}
