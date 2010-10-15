#!/usr/bin/perl

use strict;
use warnings;

#gen_primes_array(<min>)
#returns array of prime numbers between 2 and min
sub gen_primes_array{
	my @primes;
	for (my $i=2;$i<=$_[0];$i++){
        	my $prim=1;
	        for (my $j=2;$j<=sqrt($i);$j++){
        	        if ($i % $j==0){
                	        $prim=0;
                        	last;
	                }
        	}
	        if ($prim==1){
        	        push(@primes,$i);
	        }
	}
	print "Primes array initialised (".$primes[0]."...".$primes[$#primes-1].")\n";
	return @primes;
}

my $min=10000;
my $max=20000;

my @primes=&gen_primes_array($min);

for (my $i=$min;$i<=$max;$i++){
	my $prim=1;
	for (my $j=0;$j<$#primes;$j++){	
		if ($primes[$j] <= sqrt($i)){
			if ($i % $primes[$j]==0){
				$prim=0;
				last;
			}
		}
#		else{
#			print "$primes[$j] reached!\n";
#		}
	}
	if ($prim==1){
		print "$i\n";
		push (@primes,$i);
	}
}

