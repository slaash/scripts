#!/usr/bin/perl

use strict;
use warnings;

use threads;
use threads::shared;

use IO::Socket;

sub chitchat{
	my $client=$_[0];
        print $client "Hello!\n";
        my $remotehost=$client->peerhost();
        my $remoteport=$client->peerport();
        while(<$client>){
 	       print $client "You said: $_\n";
        }
        #no more access to client after this point
        print "Client $remotehost:$remoteport left\n";
        exit;
}

my $server=IO::Socket::INET->new(LocalPort=>33333,Type=>SOCK_STREAM,Proto=>'tcp',Reuse=>1,Listen=>SOMAXCONN) or die $@;

while(my $client=$server->accept){
	my $thread=threads->new(\&chitchat,$client);
	$thread->detach;
	print "Forked connection for client ".$client->peerhost().":".$client->peerport()."\n";
}

