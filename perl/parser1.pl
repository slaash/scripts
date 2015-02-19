#!/usr/bin/perl

use strict;
use warnings;

use XML::DOM;
use Data::Dumper;

my $file=$ARGV[0] or die "XML file missing !";
	
my $parser = new XML::DOM::Parser;
my $doc = $parser->parsefile($file);

my $elem;
my @alldata = $doc->getElementsByTagName('file');
foreach $elem(@alldata){
	my @tags=$elem->getChildNodes;
	for my $item(@tags){
		my $buf=$item->getNodeName;
		if ($buf ne "#text"){
			print "Node name: $buf\n";
			my @childs=$item->getChildNodes;
			foreach (@childs){
				if ($_->getNodeName ne "#text"){
					print "\t".$_->getNodeName." =".$_->getFirstChild()->getData()."\n";
				}
			}
		}
	}
}
