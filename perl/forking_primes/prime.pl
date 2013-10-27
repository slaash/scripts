#!/usr/bin/perl

use strict;
use warnings;

my $min=$ARGV[0];
my $max=$ARGV[1];

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

my $parallel = 10;
my $running = 0;
my $result;

#$SIG{CHLD}="IGNORE";

for (my $i=$min;$i<=$max;$i++){
	my $pid=fork;
	if ($pid==0){
		&is_prime($i);
		exit;
	}
	else{
#		print "Running childs: ".($running+1)."\n";
                $running++;
                if ($running >= $parallel) {
#			print "Waiting...\n";
                        $result = wait;
                        $running--;
                }
	}
}

#wait for all children to finish
while (wait() != -1) {}
print "Done\n";

