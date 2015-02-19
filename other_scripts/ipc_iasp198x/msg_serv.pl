#!/usr/bin/perl

use strict;
use warnings;

use IPC::SysV;
use IPC::Msg;

my $msg = IPC::Msg->new("0x0000000a", "S_IRUSR | S_IWUSR");

my $buf="";
my $last_buf="";
while (1){
	$msg->rcv($buf,10);
	$last_buf=$buf;
	if ($buf ne $last_buf){
		print "$buf\n";
	}
}

