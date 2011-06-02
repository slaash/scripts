#!/usr/bin/perl

use strict;
use warnings;

use Digest::MD5;

my $RAND="/dev/urandom";
my $TESTFILE="/home/uidl9555/somefile";

sub get_used_mem{
	open(my $file, '<' ,"/proc/$$/status");
	while (<$file>){
		chomp $_;
		if ($_ =~ /VmSize:\s+\d+\s+kB/){
			return "$_";
		}
	}
	close($file);
}

open(my $in, '<', $RAND) or die $!;
open(my $out, '>', $TESTFILE) or die $!;

my $readdata;
my $buffer;
for(my $i=0;$i<30;$i++){#30 times
	sysread($in,$buffer,10240000);#10 MB
	syswrite($out,$buffer)
}

close($out);
close($in);

my $holdTerminator = $/;
undef $/;

open($in,'<',$TESTFILE) or die $!;
my $var=<$in>;
close $in;

$/ = $holdTerminator;

#my $var=`cat $TESTFILE`;#2 x memory used

my $md5 = Digest::MD5->new;

$md5->add($var);

print $md5->hexdigest."\n";

print &get_used_mem."\n";

