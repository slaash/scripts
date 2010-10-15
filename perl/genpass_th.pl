#!/usr/bin/perl

use Crypt::GeneratePassword qw(word);
use threads;
use threads::shared;

my $thrmax : shared = 10;

for ($i=0;$i<$thrmax;$i++){
	$thr[$i] = threads->new(\&genpass);
	$thr[$i]->detach;
	print "thread ".$thr[$i]->tid." detached\n";
}

sub genpass{
	my $pass;
	$pass=word(20,20);
	print threads->self->tid.": $pass\n";
	lock ($thrmax);
	$thrmax--;
}

while ($thrmax>0){}
