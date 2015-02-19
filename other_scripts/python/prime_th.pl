#!/usr/bin/perl

use strict;
use warnings;
use POSIX;
use threads;

my $min=$ARGV[0];
my $max=$ARGV[1];

sub check_prime{
        my $n=$_[0];
        my $prim=1;
        for (2..sqrt($n)){
                if (fmod($n,$_)==0){
                        $prim=0;
                        last;
                }
        }
        if ($prim==1){
                return $n;
        }
        else{
                return -1;
        }
}

my $thr;
my @res;
for my $i ($min..$max){
        $thr=threads->create('check_prime',$i);
        push(@res,$thr->join());
}

for (@res){
        if ($_ != -1){
                print "$_\n";
        }

