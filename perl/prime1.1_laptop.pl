#!/usr/bin/perl

use strict;
use warnings;

my $min=$ARGV[0];
my $max=$ARGV[1];

for my $i ($min..$max){
	my $prim=1;
	for my $j (2..sqrt($i)){
		if ($i%$j==0){
			$prim=0;
			last;
		}
	}
	if ($prim==1){
		print "$i\n";
	}
}

