#!/usr/bin/perl

use strict;
use warnings;

my $min=100000000000;
my $max=100000001100;

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

my $parallel = 5;
my $running = 0;
my $result;

$SIG{CHLD}="IGNORE";

for (my $i=$min;$i<=$max;$i++){
	my $pid=fork;
	if ($pid==0){
		&is_prime($i);
		exit;
	}
	else{
#		print "Runners: $running\n";
                $running++;
                if ($running >= $parallel) {
#			print "Waiting...\n";
                        $result = wait;
                        $running--;
                }
	}
}

