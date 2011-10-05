#!/usr/bin/perl

use strict;
use warnings;

use threads;
use threads::shared;

my $string : shared;
$string="";

sub ticker{
	my $wait=$_[0];
	print threads->self()->tid().": started timer for $wait sec\n";
	my $old_string="";
	while(1){
		if ($old_string and $old_string ne $string){
			print "$string: hmm, a new one!\n";
			$old_string=$string;
		}
		last if $string eq "exit";
		sleep($wait);
	}
	threads->exit;
}

my $t=threads->create(\&ticker,"1");

while(1){
	$string=<STDIN>;
	chomp $string;
	last if $string eq exit;
}

$t->join();

