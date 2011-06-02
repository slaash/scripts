#!/usr/bin/perl

use strict;
use warnings;

use PDF::API2;

use Data::Dumper;

my $pdf = PDF::API2->new();

$pdf = PDF::API2->open($ARGV[0]);

my $page=$pdf->openpage(1);



