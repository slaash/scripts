#!/usr/bin/perl6

#$Id$
#$Revision$
#$Date$

our $VERSION = 1;

#my $min = $ARGS[0];
#my $max = $ARGS[1];

sub MAIN ($min=1, $max=10){

loop (my $i = $min;$i<= $max;$i++ ) {
	my $prim = 1;
	loop ( my $j=2;$j<= sqrt $i;$j++ ) {
		if ( $i % $j == 0 ) {
			$prim = 0;
			last;
		}
	}
	if ( $prim == 1 ) {
		print "$i\n";
	}
}
}
