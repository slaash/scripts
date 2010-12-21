#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;

unlink "/tmp/unixsockd.sock";
my $server = IO::Socket::UNIX->new(Local => "/tmp/unixsockd.sock", Type => SOCK_DGRAM, Listen => 1) or warn $@;

my $client = IO::Socket::UNIX->new(Peer => "/tmp/unixsockd.sock", Type => SOCK_DGRAM, Timeout => 10) or warn $@;

if (-e "/tmp/unixsockd.sock"){
	print "Socket OK!\n";
}
else{
	print "Socket failure\n";
	exit;
}

$client->send("Test\n");

my $cl=<$server>;
print "Client: $cl\n";
	
$client->close;
$server->close;

