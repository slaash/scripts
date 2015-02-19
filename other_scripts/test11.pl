#!/usr/bin/perl -I/HOME/uidl9555/msext/lib

use strict;
use warnings;
use HTML::Entities;
use Encode qw/encode decode/;

my $basedir="/HOME/uidl9555/paext";
do "$basedir/csfunc.pl";

my $str1="[2010-07-19 16:18:05, pbeurton]This timeout error may be corrected by changing the value of the timeout in HSTI library. Looking at the visual studio traces , we notice that the response &quot;OK&quot; of ParrotCK to AT*PSDM=1 happens more than 2 seconds after.&#13;&#10;&#13;&#10;Meanwhile the timeout occurs in Host (VS.txt, ln:3778). By changing the timeout value (see resolved bugs BMWextWZ#4961 and MM1_WZ#6573), we should never have this issue again.[2010-07-19 16:18:57, pbeurton]Please see BMWextWZ#4961 and MM1_WZ#6573";

my $str=decode("UTF-8",&HTML_codec("dec",$str1));

print $str."\n";

my @parts=split(/(\[\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d, (?:\w+|\w+\s+\w+)\])/i,$str);

for (@parts){
	print "part: $_\n";
}

