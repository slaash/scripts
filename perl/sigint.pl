#!/usr/bin/perl

use strict;
use warnings;

sub action{
	print "PID $$ exits!\n";
	for (my $i=5;$i>=1;$i--){
		print "$i\n";
		sleep 1;
	}	
	exit;
}

$SIG{"INT"}='action';

while(){}
