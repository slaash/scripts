#!/usr/bin/perl

use strict;
use warnings;

my @arr=("a","b","d");
my @orig=@arr;

for (my $i=$#arr;$i>0;$i--){
	my $randPos=rand($#arr+1);
	my $tmp=$arr[$i];
	$arr[$i]=$arr[$randPos];
	$arr[$randPos]=$tmp;
}

for (my $i=0;$i<=$#arr;$i++){
	print "$orig[$i] $arr[$i]\n";
}

