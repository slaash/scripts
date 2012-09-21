#!/usr/bin/perl

use Perl::Critic; 

my $file = shift; 
my $critic = Perl::Critic->new(); 
my @violations = $critic->critique($file); 
print @violations;

