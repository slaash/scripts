#!/usr/bin/perl

use strict;
use warnings;

my $pid=fork;
if ($pid==0){
	system("xterm");
}
else{
	print "still here";
	while(<>){
		chomp $_;
		if ($_ eq "q"){
			exit;
		}
	}
}

