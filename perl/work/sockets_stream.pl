#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket::UNIX qw(SOCK_STREAM SOMAXCONN);

unlink "/tmp/unixsockd.sock";
my $server = IO::Socket::UNIX->new(Local => "/tmp/unixsockd.sock", Type => SOCK_STREAM, Listen=>SOMAXCONN) or warn $@;
my $srv_sock=$server->accept() or warn $@;

my $client = IO::Socket::UNIX->new(Peer => "/tmp/unixsockd.sock", Type => SOCK_STREAM) or warn $@;

if (-e "/tmp/unixsockd.sock"){
        print "Socket OK!\n";
}
else{
        print "Socket failure\n";
        exit;
}

my $data;

$client->send("Hello!");
$srv_sock->recv($data,1024);
print "Client: $data\n";

#print $server "Hello!";
#$client->recv($data,1024);
#print "Server: $data\n";

$client->close;
$server->close;

