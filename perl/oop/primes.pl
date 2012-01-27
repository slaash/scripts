#!/usr/bin/perl

use strict;
use warnings;

use prime;

for ($ARGV[0]..$ARGV[1]){
	my $prim=new prime($_);
	if ($prim->is_prime() == 1){
		print "$_\n";
	}
}

