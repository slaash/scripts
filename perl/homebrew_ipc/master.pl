#!/usr/bin/perl
#v.1
#uses a file (comm_file) created by master to send commands to slaves
#ex.: slave_id:die
#slave removes the line from the file before executing the command
#slaves should register with master: file with running slaves' ids
#v.2
#master maintains hash:
#running_slave_id:command
#hash is written to master_to_slaves_file 1/sec
#registered slaves are added as running_slave_id
#slaves read constantly the master_to_slaves_file
#if slave id matches it executes the command and tries to update the slaves_to_master_file 
#if file is busy it tries several times with sleep of x sec
#v.3
#pre-req: master starts the slaves, records pid
#master maintains hash:
#running_slave_pid
#commands are wrote to the hash as 'running_slave_id => (cmd timestamp : running_slave_id:command,...)'
#(running_slave_pid => ( runtime => <run timestamp>,
#			 cmd => <optional command>),
#...
#)

use strict;
use warnings;

use IPC::Open3;

use threads;
use threads::shared;

use Text::CSV;

my %slaves:shared;
my $master_done:shared;
$master_done=0;

sub ticker{
        my $wait=$_[0];
	print "\t".threads->self()->tid()." - ticker: started timer for $wait sec\n";
	while($master_done==0){
		sleep($wait);
		&slaves_to_file;
		print "\tticker: slaves\n";
		for (keys %slaves){
			print "\t$_\n";
		}
		sleep($wait);
	}
	print "\texiting ticker...\n";
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

sub spawn_slave_fork{
	#DO NOT USE!!!
	my $s_pid=fork();
	if ($s_pid==0){
		my ($chld_in, $chld_out, $chld_err);
		my $pid=open3($chld_in, $chld_out, $chld_err, 'perl ./slave.pl');
		print "master: slave $pid started\n";
		$slaves{$pid}="";
		waitpid( $pid, 0 );
		print "master: slave exited\n";
		delete $slaves{$pid};
		exit;
	}
	#DO NOT USE!!!
}

sub spawn_slave_thr{
	my ($chld_in, $chld_out, $chld_err);
	my $pid=open3($chld_in, *STDOUT, $chld_err, 'perl ./slave.pl');
	print "master: slave $pid started\n";
	$slaves{$pid}="running";
	waitpid( $pid, 0 );
	print "master: slave exited\n";
	delete $slaves{$pid};
}


my $ticker=threads->create(\&ticker,"1");

my @thr;
for (1..2){
	$thr[$_]=threads->create(\&spawn_slave_thr); 
}

print "back to master\n";
for (1..5){
	print "master...$_\n";
	sleep(1);
}
print "master is done\n";
$master_done=1;

for (1..2){
	$thr[$_]->join();
}

$ticker->join();

