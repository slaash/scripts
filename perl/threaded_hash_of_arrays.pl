#!/usr/bin/perl

use strict;
use warnings;

#use 5.010;

use threads;
use threads::shared;

use Data::Dumper;

do "./used_mem.pl";

print &get_used_mem;

my %hash_of_arrays : shared;
my $crt : shared;
$crt=0;

my $nthreads=$ARGV[0] || 100;#100 threads by default
my $elems=$ARGV[1] || 1000;

sub add_an_array{
	print "T";
	lock $crt;
	$crt++;
	my @array;
	push(@array,int(rand($elems))) for (1..$elems);
#	push(@array,0) for (1..$elems);
#	@array=sort {$a<=>$b} @array;
	$hash_of_arrays{$crt}=shared_clone(\@array);
	print "F";
}

my @threads;
for (1..$nthreads){
	my $thr;
	$thr=threads->create(\&add_an_array);
	if (!defined $thr){
		die "could not create thread: ".$!;
	}
	if (threads->list()<=10){
#	if (threads->list(threads::running)<=10){
		push (@threads,$thr);
		print "A";
	}
	else{
		print "J";
		$thr->join();
	}
}
print "\n";

print &get_used_mem;

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

print &get_used_mem;

