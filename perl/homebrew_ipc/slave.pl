#!/usr/bin/perl

use strict;
use warnings;

use Storable qw(lock_store lock_nstore lock_retrieve retrieve);

use threads;
use threads::shared;

use Text::CSV;

sub ticker{
	my $wait=$_[0];
	print "\t\t".threads->self()->tid()." - ticker: started timer for $wait sec\n";
	while(1){
		if (-f 'slaves_stats.csv'){
			print "\t\tslave: slaves\n";
			my $csv=Text::CSV->new({sep_char=>';'});
			open my $file,"<","slaves_stats.csv";
			while(my $csv_row=$csv->getline($file)){
				if ($csv_row->[0] == $$){
					print "\t\t$csv_row->[0] -> $csv_row->[1]\n";
				}
			}
			close $file;
			sleep($wait);
		}
		else{
			print "\t\tno slaves_stats.csv\n";
		}
	}
	print "\t\texiting ticker...\n";
}

print "\t\tslave: PID $$ started\n";

my $ticker=threads->create(\&ticker,"1");


while(1){
}

$ticker->join();

