#!/usr/bin/perl

#my $orig=$ARGV[0];
#chomp $orig;
#print "trying $orig...\n";

sub is_pal{
	my $orig=$_[0];
	my $is_pal=1;
	for (my $i=0;$i<length($orig)/2;$i++){
		if (substr($orig,$i,1) ne substr($orig,length($orig)-$i-1,1)){
			$is_pal=0;
			break;
		}
	}
	if ($is_pal){
		print "$$: ---$orig---\n";
		return 1;
	}
	return 0;
}

while (<>){
	my $orig=$_;
	chomp $orig;

	my $done=0;
	for ($i=length($orig);$i>=2 && $done==0;$i--){
		for ($j=0;$j<=length($orig)-$i && $done==0;$j++){
			$done=is_pal(substr($orig,$j,$i));
		}
	}
}

