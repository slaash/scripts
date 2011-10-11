#!/usr/bin/perl

use strict;
use warnings;

use Storable qw(lock_store lock_nstore lock_retrieve retrieve);

use threads;
use threads::shared;

use Data::Dumper;

sub ticker{
	my $wait=$_[0];
	print "\t\t".threads->self()->tid()." - ticker: started timer for $wait sec\n";
	while(1){
		if (-f 'comm_file.dat'){
			my $slaves=lock_retrieve('comm_file.dat');
			print "\t\tslave: slaves\n";
#			for (keys %$slaves){
#				print "\t\t$_\n";
#			}
			print Dumper $slaves;
			sleep($wait);
		}
		else{
			print "\t\tno comm_file.dat\n";
		}
	}
	print "\t\texiting ticker...\n";
}

print "\t\tslave: PID $$ started\n";

my $ticker=threads->create(\&ticker,"1");


while(1){
}

$ticker->join();

