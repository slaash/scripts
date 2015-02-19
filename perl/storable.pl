#!/usr/bin/perl

use strict;
use warnings;

use 5.010;

use Storable qw(lock_store lock_retrieve);

use Data::Dumper;

use threads;
use threads::shared;

my %shared_hash;
sub set_n_store{
	%shared_hash=("q"=>1,
			"w"=>2,
			"e"=>3);
        for (keys %shared_hash){
                say "$_ => $shared_hash{$_}";
        }
	lock_store(\%shared_hash,'stored.txt');
}
sub retrieve_n_set{
	my $hashref=lock_retrieve('stored.txt');
	%shared_hash=%$hashref;
	for (keys %shared_hash){
		say "$_ => $shared_hash{$_}";
	}
}
my $thr=threads->create(\&set_n_store);
$thr->join;
$thr=threads->create(\&retrieve_n_set);
$thr->join;

say "-" x 10;

my %hash=("a" => 1,
	"b" => 2,
	"c" => 3);
my @arr=(111,222,333);
my $var="asdf";

for(keys %hash){
	say "$_ => $hash{$_}";
}
for (@arr){
	say $_;
}
say $var;

say "-" x 10;

lock_store(\%hash,'stored.txt');
my $hashref=lock_retrieve('stored.txt');
for(keys %$hashref){
	say "$_ => $$hashref{$_}";
}

lock_store(\@arr,'stored.txt');
my $arrayref=lock_retrieve('stored.txt');
for (@$arrayref){
	say $_;
}

lock_store(\$var,'stored.txt');
my $ref=lock_retrieve('stored.txt');
say $$ref;

