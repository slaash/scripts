use IO::Socket;

$sock = new IO::Socket::INET (
                                  PeerAddr => 'localhost',
                                  PeerPort => '7070',
                                  Proto => 'tcp',
                                 );
print $sock "Hello there!\n";
close($sock);
