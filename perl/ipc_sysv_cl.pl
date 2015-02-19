#!/usr/bin/perl

use strict;
use warnings;

use IPC::SysV;
use IPC::SharedMem;

my $shm = IPC::SharedMem->new(10, 1024, "RW");

my $var;

while (<>){
	$shm->write($_,0,length($_));
}

