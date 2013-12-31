#!/usr/bin/perl

my $orig=$ARGV[0];
chomp $orig;

sub is_pal{
	my $orig=$_[0];
	my $is_pal=1;
	for (my $i=0;$i<length($orig);$i++){
		if (substr($orig,$i,1) ne substr($orig,length($orig)-$i-1,1)){
			$is_pal=0;
			break;
		}
	}
	if ($is_pal){
		print "$orig\n";
		exit;
	}
}

for ($i=length($orig);$i>=2;$i--){
	for ($j=0;$j<=length($orig)-$i;$j++){
		is_pal(substr($orig,$j,$i));
	}
}

