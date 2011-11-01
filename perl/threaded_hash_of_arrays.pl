#!/usr/bin/perl

use strict;
use warnings;

#use 5.010;

use threads;
use threads::shared;

use Data::Dumper;

my %hash_of_arrays : shared;
my $crt : shared;
$crt=0;

sub add_an_array{
	lock $crt;
	$crt++;
	my @array;
#	push(@array,int(rand(1000))) for (1..1000);
	push(@array,0) for (1..1000);
#	@array=sort {$a<=>$b} @array;
	$hash_of_arrays{$crt}=shared_clone(\@array);
	print "T";
}

my @threads;
for (1..900){
	my $thr;
	$thr=threads->create(\&add_an_array);
	if (!defined $thr){
		die "could not create thread...";
	}
	if (threads->list(threads::running)<=10){
		push (@threads,$thr);
		print "A";
	}
	else{
		print "J";
		$thr->join();
	}
}
print "\n";

print $#threads." threads remaining\n";
for (0..$#threads){
	print "F";
	$threads[$_]->join();
}

my @keys=keys %hash_of_arrays;

#for (sort {$a<=>$b} @keys){
#	print "$_: ";
#	for (@{$hash_of_arrays{$_}}){
#		print "$_ ";
#	}
#	print "\n";
#}

print "\n";
print $#keys+1;
print " keys in hash\n";

