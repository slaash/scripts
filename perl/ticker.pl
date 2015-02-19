#!/usr/bin/perl

use strict;
use warnings;

use 5.012;

use threads;
use threads::shared;

my $string : shared;
$string="";

sub ticker{
	my $wait=$_[0];
	print "\t".threads->self()->tid()." - ticker: started timer for $wait sec\n";
	my $old_string="";
	while($string ne "exit" and $string ne "exit ticker"){
		if ($old_string ne $string){
			print "\t$string: hmm, a new one!\n";
			$old_string=$string;
		}
		sleep($wait);
	}
	print "\texiting ticker...\n";
}

sub watcher{
	my $wait=$_[0];
	print "\t\t".threads->self()->tid()." - watcher: started timer for $wait sec\n";
	while($string ne "exit" and $string ne "exit watcher"){
		print "\t\t".localtime().": threads available\n";
		for (threads->list(threads::running)){
			print "\t\t".$_->tid()."\n";
		}
		sleep($wait);
	}
	print "\t\texiting watcher...\n";
}

my $ticker=threads->create(\&ticker,"1");
my $watcher=threads->create(\&watcher,"3");

while($string=<>){
	chomp $string;
	last if $string eq "exit";
}
print "exiting main...\n";

$ticker->join();
$watcher->join();

