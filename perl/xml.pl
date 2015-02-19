#!/usr/bin/perl

use strict;
use warnings;
use XML::Parser;

sub tag{
#	print $_[1];
}

sub attr{
	print $_[1];
}

my $xml=new XML::Parser();
$xml->setHandlers(Start=>\&tag,
		Char=>\&attr);
$xml->parsefile("file.xml");

