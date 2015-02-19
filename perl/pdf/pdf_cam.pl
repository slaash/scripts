#!/usr/bin/perl

use strict;
use warnings;

use CAM::PDF;

sub replace_german_chars{
        my $text=$_[0];
        my %conv_table=("<E4>" => "ae",
                        "<C4>" => "Ae",
                        "<F6>" => "oe",
                        "<D6>" => "Oe",
                        "<FC>" => "ue",
                        "<DC>" => "Ue",
                        "<DF>" => "sz");
        foreach (keys %conv_table){
                $text=~s/$_/$conv_table{$_}/g;
        }
        #here we remove all chars below ASCII code 32 and above 126;actually we only keep the rest
        #order of calls should be replace_german_chars then UTF-8 encode
        $text =~ tr/\012\015\036\040-\176//cd;
        $text=~s/\\+/\\\\/g;
        $text=~s/\\*`/\\`/g;
        $text=~s/\\*"/\\"/g;
        $text=~s/\\*\$/\\\044/g;
        return $text;
}

my $pdf = CAM::PDF->new($ARGV[0]);

print $pdf->numPages();

my $pg=1;
while ($pg<=$pdf->numPages()){
	print &replace_german_chars($pdf->getPageText($pg));
	$pg++;
}

