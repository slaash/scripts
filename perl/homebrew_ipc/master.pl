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

use Storable qw(lock_store lock_nstore lock_retrieve);
use IPC::Open3;

sub check_comm_file{
#valid commands: die#proc_id
	my $comm_file=$_[0];
	unless (-f $comm_file){
		open my $file,">",$comm_file;
		print $file "";
		close $file;
	}
}

sub spawn_slave{
	my $s_pid=fork();
	if ($s_pid==0){
		my($chld_out, $chld_in, $chld_err);
		my $pid=open3($chld_out, $chld_in, $chld_err, 'perl ./slave.pl');
		print "master: slave $pid started\n";
		waitpid( $pid, 0 );
		print "master: slave exited\n";
		exit;
	}
}

&spawn_slave;

print "back to master\n";
while(1){
}

