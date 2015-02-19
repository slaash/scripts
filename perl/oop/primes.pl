#!/usr/bin/perl

use strict;
use warnings;

use prime;

my @numbers;

for ($ARGV[0]..$ARGV[1]){
	my $prim=new prime($_);
	push(@numbers,$prim);
}

for (@numbers){
        if ($_->is_prime() == 1){
                print "$_\n";
        }
}

