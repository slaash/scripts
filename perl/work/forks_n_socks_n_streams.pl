#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket::UNIX qw(SOCK_STREAM SOMAXCONN);

my $sock="/tmp/unixsockd.sock";
unlink $sock;

if (my $pid=fork){
	print "$$: Parent\n";
        my $srv = IO::Socket::UNIX->new(Local => $sock, Type => SOCK_STREAM, Listen => SOMAXCONN) or warn $@;
	if (-e "$sock"){
                print "Server socket OK!\n";
        }
        else{
                print "Server socket failure\n";
                exit;
        }
	my $srv_sock=$srv->accept() or warn $@;
	print "Server listening...\n";
        while(<>){
		chomp $_;
                print $srv_sock "$_\n";
		my $line=<$srv_sock>;
		chomp $line;
		print "Client responded: $line\n";
		last if ($_ eq "quit");
        }
	print "Parent finished\n";
	$srv->close or warn $@;
}
elsif (!defined $pid){
	print "Can't fork!\n";
}
else{
	print "$$: Child\n";
	while (!(-e $sock)){}
	my $client = IO::Socket::UNIX->new(Peer => $sock, Type => SOCK_STREAM) or warn $@;
	while (<$client>){
		chomp $_;
		print "Server said: $_\n";
		print $client "$_ back to you!\n";
		last if ($_ eq "die");
	}
	print "pid: $pid\n";
        print "Child finished\n";
	$client->close or warn $@;
}

