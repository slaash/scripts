#!/usr/bin/perl

use strict;
use warnings;

my $min=1000000000000000;
my $max=1000000000000100;

sub is_prime{
	my $n=$_[0];
	my $prim=1;
	#proof that it works!
	#while(1){};
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

for (my $i=$min;$i<=$max;$i++){
	&is_prime($i);
}

