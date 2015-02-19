#!/usr/bin/perl

use strict;
use warnings;

open FILE,"/dev/urandom";

for (1..10){
	while (<FILE>){
		if ($_ =~ m/(\w{12})/){
			print "$1: ".length($_)."\n";
		}
	}
}

close FILE;

