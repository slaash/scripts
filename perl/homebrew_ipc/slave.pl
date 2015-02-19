#!/usr/bin/perl

use strict;
use warnings;

use Storable qw(lock_store lock_nstore lock_retrieve retrieve);

use threads;
use threads::shared;

use Text::CSV;

my $master_done:shared;
$master_done=0;

sub ticker{
	my $wait=$_[0];
	print "\t\t\t".threads->self()->tid()." - ticker: started timer for $wait sec\n";
	while($master_done==0){
		if (-f 'slaves_stats.csv'){
			print "\t\t\tslave: slaves\n";
			my $csv=Text::CSV->new({eol=> $/, sep_char=>';'});
			open my $file,"<","slaves_stats.csv";
			while(my $csv_row=$csv->getline($file)){
				if ($csv_row->[0] == $$){
					print "\t\t\t$csv_row->[0] -> $csv_row->[1]\n";
				}
			}
			close $file;
			sleep($wait);
		}
		else{
			print "\t\t\tno slaves_stats.csv\n";
		}
	}
	print "\t\t\texiting ticker...\n";
}

print "\t\tslave: PID $$ started\n";

my $ticker=threads->create(\&ticker,"1");

print "\t\tback to slave\n";

for (1..5){
	print "\t\tslave...$_\n";
	sleep(1);
}
print "\t\tslave is done\n";
$master_done=1;

$ticker->join();

