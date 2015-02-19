#!/usr/bin/perl

use strict;
use warnings;

use IPC::SysV qw(IPC_PRIVATE S_IRUSR S_IWUSR);
use IPC::SharedMem;

my $shm = IPC::SharedMem->new(10, 1024, "R");

my $var="Server ready!!!";

$shm->write($var,0,length($var));

my $last_var="";
while (1){
	$var=$shm->read(0,length($var));
	if ($var ne $last_var){
		chomp $var;
		$last_var=$var;
		print "Client: $var\n";
	}
}

