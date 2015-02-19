#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;
use threads;

our $ADDR ||= 'localhost:35007';

my $listener = IO::Socket::INET->new(
    LocalAddr => $ADDR,
    Listen => 5,
    Reuse   => 1,
) or die $^E;

while( my $client = $listener->accept ) {
    async {
        my($port, $iaddr) = sockaddr_in( getpeername( $client ) );
        printf "From %s:%d: %s", join('.',unpack 'C4', $iaddr ), $port, $_
            while <$client>;
        close $client;
    }->detach;
}

