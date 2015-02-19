#!/usr/bin/perl

@LIST=split(/\,/,$ARGV[0]);
foreach $port(@LIST){
    open (CMD,"hping3 -c 1 -p ".$port." -S ".$ARGV[1]."|"); 
    while ($LINIE=<CMD>){
	chomp $LINIE;
	if ($LINIE =~ /^len/){
	    push @REZ,$LINIE."\n";
	}
    }
    close CMD;
}
print "\n\nREZULTAT:\n";
print @REZ;
