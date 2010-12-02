#!/usr/bin/perl

use IO::Socket;
use CGI qw/:standard/;

while (1){
$sock = new IO::Socket::INET (
                                  LocalHost => '192.168.172.3',
                                  LocalPort => '7070',
                                  Proto => 'tcp',
                                  Listen => 1,
                                  Reuse => 1,
                                 );
$new_sock = $sock->accept();
while(<$new_sock>) {
	print $_;
	print $new_sock "HTTP/1.1 404 Not Found\n";
print $new_sock "Date: Sat, 12 Aug 2006 20:34:29 GMT\n";
print $new_sock "Server: Apache\n";
print $new_sock "Content-Length: 302\n";
print $new_sock "Connection: close\n";
print $new_sock "Content-Type: text/html; charset=iso-8859-1\n";
print $new_sock "\n";
print $new_sock "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\"\n";
print $new_sock "<html><head>\n";
print $new_sock "<title>404 Not Found</title>\n";
print $new_sock "</head><body>\n";
print $new_sock "<h1>Not Found</h1>\n";
print $new_sock "</body></html>\n";
print $new_sock "\n";	
	
	
}
close($sock);
}
