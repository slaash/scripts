#!/usr/bin/perl

use strict;
use warnings;
#use 5.012;

use bignum;

use threads;
use threads::shared;

use Benchmark ':hireswallclock';

sub is_prime{
        my $n=$_[0];
        my $prim=1;
        #proof that it works!
        #while(){};
        for (my $j=2;$j<=sqrt($n);$j++){
                if ($n%$j==0){
                        $prim=0;
                        last;
                }
        }
        if ($prim==1){
                print "$n\n";
        }
        else{
#               warn "Discard $n\n";
        }
}

sub main{

my @threads;
for (my $i=$ARGV[0];$i<=$ARGV[1];$i++){
        my $thr=threads->create(\&is_prime,$i);
        if (scalar threads->list(threads::running)<8){
                push(@threads,$thr);
        }
        else{
#               warn "Waiting for thread ".$thr->tid." of ".scalar threads->list(threads::running)."...\n";
                $thr->join;
        }
}

for (@threads) {
#       warn "Waiting for thread ".$_->tid." of ".scalar threads->list()."...\n";
        $_->join;
}

print "Done!\n";
}

print timestr(timeit(5,&main));


