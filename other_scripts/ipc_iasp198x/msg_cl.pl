#!/usr/bin/perl

use strict;
use warnings;

use IPC::SysV;
use IPC::Msg;

my $msg = IPC::Msg->new("0x0000000a", "S_IRUSR | S_IWUSR");

my $msgtype;
while (<>){
	$msg->snd("","MUMU");
}

