#!/usr/bin/perl

use strict;
use warnings;
#use 5.012;

#use bignum;

use Thread::Pool::Simple;

sub is_prime{
	my $n=$_[0];
	my $prim=1;
	for (my $j=2;$j<=sqrt($n);$j++){
		if ($n%$j==0){
			$prim=0;
			last;
		}
	}
	if ($prim==1){
		print "$n\n";
	}
}

my $pool=Thread::Pool::Simple->new(min=>10,max=>10,passid=>0,do=>[\&is_prime]);

use bignum;

for (my $i=$ARGV[0];$i<=$ARGV[1];$i++){
	$pool->add(($i));
}

$pool->join();

print "Done!\n";

