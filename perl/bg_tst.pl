#!/usr/bin/perl

use strict;
use warnings;
use Tie::IxHash;
use POSIX;

@attrib_list=("attr1","attr2","attr3","attr4","attr5","attr6");

sub add_val_to_hash{
}

sub add_hash_to_array{
}

open FILE,"input_test.file";
while ($line=<FILE>){
	if ($line !~ /^#/){
		chomp $line;
		@l=split(/\t/,$line);
		foreach $i (@l){
			&add_val_to_hash($i);
		}
