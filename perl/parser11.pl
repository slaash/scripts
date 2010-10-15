#!/usr/bin/perl

use strict;
use warnings;

use XML::DOM;
use Data::Dumper;

my $file=$ARGV[0] or die "XML file missing !";
	
my $parser = new XML::DOM::Parser;
my $doc = $parser->parsefile($file);

my @alldata = $doc->getElementsByTagName('file');
foreach (@alldata){
	my @elements=$_->getChildNodes;
	foreach (@elements){
		if ($_->getNodeName ne "#text"){
			print "Parent: ".$_->getNodeName."\n";
			my @childs=$_->getChildNodes;
			foreach (@childs){
				if ($_->getNodeName ne "#text"){
					print "\tChild: ".$_->getNodeName." = ".$_->getFirstChild()->getData()."\n";
				}
			}
		}
	}
}
