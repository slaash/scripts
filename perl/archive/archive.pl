#!/usr/bin/perl

use strict;
use warnings;

use Archive::Zip;

my $zip = Archive::Zip->new("file.zip");
eval{
	$zip->extractTree('',"./");
};
if ($@){
	print "error unzipping zip\n";
}

print "Done!\n";

