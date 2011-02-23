#!/usr/bin/perl

use strict;
use warnings;

use threads;
use threads::shared;

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
}

my @threads;
for my $i ($ARGV[0]..$ARGV[1]){
	my $thr=threads->create(\&is_prime,$i);
	if (scalar threads->list()<2){
                push(@threads,$thr);
        }
        else{
#		warn "Waiting for thread ".$thr->tid." of ".scalar threads->list()."...\n";
                $thr->join;
        }
}

foreach (@threads) {
#	warn "Waiting for thread ".$_->tid." of ".scalar threads->list()."...\n";
        $_->join;
}

print "Done!\n";

