#!/usr/bin/perl

use strict;
use warnings;

my $var="mama";
my $last_var="";

my $pid=fork;
if ($pid==0){
	if ($var ne $last_var){
		print "Child: $var\n";
		$last_var=$var;
	}
}
else{
	print "Parent";
	while(<>){
		chomp $_;
		if ($_ eq "q"){
			exit;
		}
		$var=$_;
	}
}

