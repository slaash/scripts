#!/usr/local/bin/perl

use strict; 
use warnings;

my @prs;

open FILE,"not_synced_prs.txt";
while (<FILE>){
	chomp $_;
	if ($_=~/(\w+)_(\w+)_(\w+)/){
		push (@prs,"$1_$2#$3");
	}
}
close FILE;

for (@prs){
	print "$_\n";
}

print "Total: $#prs\n";

