#!/usr/bin/perl

use strict;
use warnings;
use threads;
use threads::shared;

my $cmd:shared;
$cmd="";

my $thr=threads->new(sub{
while(1){
	if ($cmd ne ""){
		system($cmd);
		$cmd="";
	}
}
});

$thr->detach;

while(<>){
	chomp $_;
	print "cmd: $_\n";
	$cmd=$_;
}

