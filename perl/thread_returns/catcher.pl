#!/usr/bin/perl

use strict;
use warnings;

use threads;
use threads::shared;

my %hash :shared;

sub display_array{
	my $arr=$_[0];
	my $cnt=$_[1];
	my $ret;
	for (@$arr){
		$ret.="$_,";
	}
	chop $ret;
	$hash{$cnt}=$ret;
}

my $arr1=["a","b","c","d"];
my $arr2=["b","c","d","e"];
my $arr3=["f","g","h","i"];
my $arr4=["j","k","l","m"];
my $arr5=["n","o","p","q"];

my @arrs=($arr1,$arr2,$arr3,$arr4,$arr5);

my $cnt=0;

my @threads;
for my $arr(@arrs){
	my $thr=threads->create(\&display_array,$arr,$cnt);
	push(@threads,$thr);
	$cnt++;	
}

foreach (@threads) {
        $_->join;
}

print "All threads done\n";

for (sort keys %hash){
	print "$hash{$_}\n";
}

