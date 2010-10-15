#!/usr/bin/perl

use strict;
use warnings;

use IPC::Shareable;

my $var;
my %options = (
	create    => 0,
	exclusive => 0,
	mode      => 0644,
	destroy   => 0,
);


tie $var,'IPC::Shareable',0x0000000a,{%options} or die "client tie error!";

while (<>){
	$var=$_;
	print "Client: $var\n";
}

exit;

