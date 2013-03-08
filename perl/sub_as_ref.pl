#!/usr/bin/perl

use strict;
use warnings;

my %values=(
        "id" => \&get_timestamp,
        "name" => \&do_stuff_to_name,
        "age" => \&lie_about_age);

sub get_timestamp{
        return time();
}

sub do_stuff_to_name{
        my $name=$_[0];
        return "aaa ".$name." aaa";
}

sub lie_about_age{
        my $name=$_[0];
        return "$name are ".int(rand(100))." ani";
}

for my $attr (keys %values){
        print &{$values{$attr}}("gigi")."\n";
}

