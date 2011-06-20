#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @chars=('a'..'z','0'..'9',' ','A'..'Z');

sub get_last_char{
	my $seq=$_[0];
	return substr($seq,length($seq)-1,1);
}

sub get_next_elem{
	my $elem=$_[0];
	my $cnt=0;
	while ($chars[$cnt] ne $elem){
		$cnt++;
	}
	if ($cnt<$#chars){
		return $cnt;
	}
	else{
		return 
}

sub gen_next_seq{
	my $seq=$_[0];
	my $char=&get_last_char($seq);
	print &get_elem_pos($char);
}


my $len=1;
my $max=4;

&gen_next_seq("abc");

