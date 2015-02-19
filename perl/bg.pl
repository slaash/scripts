#!/usr/bin/perl

use strict;
use warnings;
use Tie::IxHash;
use POSIX;

my $line;
my $index;
my %list;

tie %list, "Tie::IxHash";

$index=0;
open FILE,$ARGV[0];
while ($line=<FILE>){
	chomp $line;
	$list{$index}=$line;
	$index++;
#	print "line: $index\n";
}
close FILE;

foreach $line (keys %list){
	print "$line: $list{$line}\n";
}

