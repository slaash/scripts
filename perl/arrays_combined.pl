#!/usr/bin/perl

use strict;
use warnings;

my @a=("a","b","bb","c");
my @b=("b","c","d","dd","e");

sub combined_arrays{
	my @uniques;
	my %seen=();
	for (@_){
		push(@uniques,$_) unless $seen{$_}++;
	}
	return @uniques;
}

for (&combined_arrays(@a,@b)){
	print "$_\n";
}

