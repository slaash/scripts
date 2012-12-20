#!/usr/bin/perl

use Net::Whois::Raw;

$dominfo = whois('60.169.22.118');

print $dominfo;

