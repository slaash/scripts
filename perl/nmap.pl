#!/usr/bin/perl

use strict;
use warnings;

use Nmap::Scanner;

my $scanner = new Nmap::Scanner;

#$scanner->tcp_syn_scan();
$scanner->tcp_connect_scan();
$scanner->add_scan_port(22);
#$scanner->guess_os();
$scanner->add_target('192.168.172.204');

my $results = $scanner->scan();

print $results->as_xml();

