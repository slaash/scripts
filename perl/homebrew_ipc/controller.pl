#!/usr/bin/perl
use strict;
use warnings;

use IPC::Open3;

use threads;
use threads::shared;

use Text::CSV;

use 5.010;

my %slaves:shared;
my $master_done:shared;
$master_done=0;

sub ticker{
        my $wait=$_[0];
	say "\t".threads->self()->tid()." - ticker: started timer for $wait sec";
	while($master_done==0){
		sleep($wait);
		&slaves_to_file;
		sleep($wait);
	}
	say "\texiting ticker...";
}

sub slaves_to_file{
	my $csv=Text::CSV->new({eol=> $/, sep_char=>';'});
	open my $file,">","slaves_stats.csv";
	for (keys %slaves){
		my @line;
		push(@line,$_);
		push(@line,$slaves{$_});
		$csv->print($file,\@line);
	}
	close $file;
}

sub spawn_slave_thr{
	my ($chld_in, $chld_out, $chld_err);
	my $pid=open3($chld_in, *STDOUT, $chld_err, 'perl ./dummy.pl');
	say "master: slave $pid started";
	$slaves{$pid}="running";
	waitpid( $pid, 0 );
	say "master: slave exited";
	delete $slaves{$pid};
}

sub show_slaves{
	say "slaves";
	say "-" x 10;
	if (-e "slaves_stats.csv"){
		my $csv=Text::CSV->new({eol=> $/, sep_char=>';'});
		open my $file,"<","slaves_stats.csv";
		while(my $csv_row=$csv->getline($file)){
			if ($csv_row->[0] == $$){
				say "$csv_row->[0] -> $csv_row->[1]";
			}
		}
		close $file;
	}
	say "-" x 10;
}

my $ticker=threads->create(\&ticker,"1");

my @thr;
say "Controller ready";
while(<>){
	chomp $_;
	given ($_){
		when ("new"){
			push(@thr,threads->create(\&spawn_slave_thr));
			say "thread created";
		}
		when ("list"){
			&show_slaves;
		}
		when ("exit"){
			last;
		}
		default {
			say "Command not understood";
		}
	}
}
say "Controller finished";
$master_done=1;

my $i=0;
for (@thr){
	$thr[$i]->join();
	$i++;
}

$ticker->join();

