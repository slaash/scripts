#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

my $sock="/tmp/unixsockd.sock";
unlink $sock;

if (my $pid=fork){
	print "$$: Parent\n";
	while(!(-e "$sock")){}
        my $client = IO::Socket::UNIX->new(Peer => $sock, Type => SOCK_DGRAM, Timeout => 10) or warn $@;
        while(<>){
		chomp $_;
		print "Main thread sent: $_\n";
                $client->send("$_");
		if ($_ eq "quit"){
			$client->close;
			last;
		}
        }
	print "Parent finished\n";
}
elsif (!defined $pid){
	print "Can't fork!\n";
}
else{
	print "$$: Child\n";
	my $server = IO::Socket::UNIX->new(Local => $sock, Type => SOCK_DGRAM, Listen =>1) or warn $@;
        if (-e "$sock"){
                print "Socket OK!\n";
        }
        else{
                print "Socket failure\n";
                exit;
        }
	my $data;
	do{
		$server->recv($data,1024);
		print "Child thread got: $data\n";
	} until $server->atmark or ($data and $data eq "quit");
        print "Child finished\n";
}
