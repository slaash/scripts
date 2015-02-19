#!/usr/bin/perl

use strict;
use warnings;
use bignum;

my $min=$ARGV[0];
my $max=$ARGV[1];

for (my $i=$min;$i<=$max;$i++){
	my $prim=1;
	for (my $j=2;$j<=sqrt($i);$j++){
		if ($i%$j==0){
			$prim=0;
			last;
		}
	}
	if ($prim==1){
		print "$i\n";
	}
}

