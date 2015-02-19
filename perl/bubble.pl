#!/usr/bin/perl

use strict;
use warnings;

my $SIZE=$ARGV[0];

sub get_mem_info{
	my @l;
	open(INFO,"/proc/".getpgrp(0)."/stat");
	while (<INFO>){
		chomp $_;
		@l=split(/ /,$_);
	}
	close INFO;
	return @l;
}

my @array;

for my $i (0..$SIZE){
	my @data;
	for my $j (0..$SIZE){
		$data[$j]=$j;
	}
	$array[$i]=\@data;
	print "Pushed ".($i+1)." ".($#data+1)."-elements array to master array (".($#array+1)." elements)\n";
	my @l=&get_mem_info;
	print "\tUsed memory (PID $l[0]): ".($l[22]/1024)." KB (".int($l[22]/1024/1024)." MB)\n";
}

<STDIN>

