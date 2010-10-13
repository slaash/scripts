#!/usr/bin/perl

use warnings;
use strict;

my $nr_arrays=$ARGV[0];
my $nr_hashes=$ARGV[1];

my %hash;
my @array;

for my $arrays (1..$nr_arrays){
	for my $hash_elem (1..$nr_hashes){
		$hash{$hash_elem}=1;
	}
	push(@array,{%hash});
	print "A";
}

my $wait=<STDIN>;

