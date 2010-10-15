#!/usr/bin/perl

use strict;
use warnings;

use IPC::SysV;
use IPC::SharedMem;

#my $shm = IPC::SharedMem->new(10, 1024, 644) or die "Mumu ipc-ul";
my $shm = IPC::SharedMem->new(10, 1024, 0x29A) or die "Mumu ipc-ul";

my $var="Server ready!!!";
print "$var";

$shm->write($var,0,length($var)) or die "mumu write-u";

my $last_var="";
while (1){
	$var=$shm->read(0,length($var));
	if ($var ne $last_var){
		chomp $var;
		$last_var=$var;
		print "Client: $var\n";
		while(<>){}
	}
}

