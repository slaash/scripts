#!/usr/local/bin/perl

use strict;
use warnings;

#if ($#ARGV<0){
#	print "nu ai argumente!\n";
#	exit;
#}

my $search=$ARGV[0];
#my $text=$ARGV[1];

#my @lines=split(/\n/,$text);
my $cnt=0;
#foreach (@lines){
#	if ($_ =~ /$search/){
#		print "$_\n";
#	}
#}	

my $found=0;
while (<STDIN>){
	chomp $_;
	if ($found==1){
		print "$_\n";
		$found=0;
	}
	if ($_ =~ /$search/){
		$found=1;
	}
}


