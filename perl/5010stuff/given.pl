#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;

use 5.010;

#say "Shit!";

#my @words=qw(New in Perl 5.010);
#say for @words;

#for (@words){
#	say;
#}

#my $a;
#my $b;
#old stuff #$a=defined $b ? $b : 0;

#new way
#$a=$b || 0;
#say "a: $a";

#$a=$b // 0;
#say "a: $a";

#$a=2;
#$b=1;
#$a ||= $b;
#say "a: $a";

#sub print_var{
#	state $var=10;
#	return $var--;
#}
#for (qw(1 2 3)){
#	say &print_var;
#}

#if (-f -w "given.pl"){
#	say "E acolo, e writable";
#}

#my $expr="I love regular expressions!!!";
#my $match="I love regular expressions!";
#my @arr=qw("I love regular expressions!" something else);
#say for @arr;
#if ($match ~~ $expr){
#	say "1: Gotcha!";
#}
#if ($match ~~ @arr){
#	say "2: Gotcha!";
#}

#while (<>){
#	given ($_){
#		when (/exit/){
#			exit;
#		}
#		when (/hello/){
#			say "Hello 2 U 2!";
#		}
#		default {
#			say "Say smth!";
#		}
#	}
#}

#my @have=qw(I love regular expressions!!!);
#my @want=@have->where("regular");
#say @want;

#my $string="VWimpRbg#1234";
#my $l_re=qr/^(?<dbid>\w+)/;
#my $r_re=qr/(?<prnr>\d+)/;
#$string ~~ /$l_re#$r_re/;
#my $dbid=$+{ dbid };
#my $prnr=$+{ prnr };
#say "$prnr $dbid";

#my @arr=qw(1 2 3) x 4;
#say for @arr;

#for (qw(1) x 10){
#	say "Mama";
#}

say "Tata" for qw(1) x 10;
