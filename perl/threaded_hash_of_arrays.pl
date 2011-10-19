#!/usr/bin/perl

use strict;
use warnings;

use 5.010;

use threads;
use threads::shared;

use Data::Dumper;

my %hash_of_arrays : shared;
my $crt : shared;
$crt=0;

sub add_an_array{
	{
		lock $crt;
		$crt++;
	}
	my @array;
	push(@array,int(rand(100))) for (1..4);
	$hash_of_arrays{$crt}=shared_clone(\@array);
#	return @array;
}

my @threads;
for (1..10){
	my $thr=threads->create(\&add_an_array);
	push (@threads,$thr);
}

for (0..$#threads){
	$threads[$_]->join();
}

for (sort (keys %hash_of_arrays)){
	print "$_: ";
	for (@{$hash_of_arrays{$_}}){
		print "$_ ";
	}
	print "\n";
}

