#!/usr/bin/perl

use strict;
use warnings;

#starting last part should be given with all 4 chars
my $start_addr=$ARGV[0];
my $crt_addr=`/sbin/ifconfig|grep Scope:Global|tr -s ' '|cut -d ' ' -f 4|cut -d '/' -f 1|cut -d ':' -f 1,2,3,4,5`;
chomp $crt_addr;
$start_addr=$crt_addr.":".$start_addr;

#if no port is given then a ping scan will be issued
my $port;
if ($ARGV[1]){
        $port=$ARGV[1];
}

my @chars=(0..9,"a".."f");
my @word;
my @addr=split(/:/,$start_addr);
my $first_sufix=$addr[5];
my @elements=split(//,$first_sufix);
my ($x,$y,$z,$t)=@elements;
my $skippy0=1;
my $skippy1=1;
my $skippy2=1;
my $skippy3=1;
my $prefix=substr($start_addr,0,length($start_addr)-4);
foreach (@chars){
        if ($_ ne $x and $skippy0==1){
                next;
        }
        else{
                $skippy0=0;
        }
        $word[0]=$_;
        foreach (@chars){
                if ($_ ne $y and $skippy1==1){
                        next;
                }
                else{
                        $skippy1=0;
                }
                $word[1]=$_;
                foreach (@chars){
                        if ($_ ne $z and $skippy2==1){
                                next;
                        }
                        else{
                                $skippy2=0;
                        }
                        $word[2]=$_;
                        foreach (@chars){
                                if ($_ ne $t and $skippy3==1){
                                        next;
                                }
                                else{
                                        $skippy3=0;
                                }
                                $word[3]=$_;
                                my $result=join('',@word);
                                if ($result=~/^0+$/){
                                        $result="0";
                                }
                                else{
                                        $result=~s/^0+//g;
                                }
                                my $cmd;
                                if (!$port){
                                        $cmd="nmap -6 -oG - -sP $prefix$result|grep \"Status: Up\"";
                                }
                                else{
                                        $cmd="nmap -6 -oG - -p $port $prefix$result|grep \"\/open\/\"";
                                }
                                my $pid=fork;
                                if ($pid==0){
                                        print "$cmd\n";
                                        system "$cmd";
                                }
                                while (wait() != -1) {}
                        }
                }
        }
}

