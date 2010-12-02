#!/usr/bin/perl

use strict;
use warnings;

use CGI;

my $content=CGI->new();
print $content->header();
print $content->start_html();
print $content->h1("Mumu");
if ($content->param("query")){
	print $content->param("query");
}
	
print $content->end_html;

