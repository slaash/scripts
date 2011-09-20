#!/usr/bin/perl

use strict;
use warnings;
use sigtrap qw(handler action normal-signals);

sub action{
	print "PID $$ exits!\n";
	for (my $i=5;$i>=1;$i--){
		print "$i\n";
		sleep 1;
	}	
	exit;
}

#for (keys %SIG){
#	$SIG{"$_"}='action';
#}

#system("ssh iasp209x '$(perl /home/uidl9555/scripts/perl/bucla.pl')");

print "PID: $$\n";

while(){}

