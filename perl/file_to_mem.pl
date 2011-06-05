#!/usr/bin/perl

use strict;
use warnings;

use Digest::MD5;

my $RAND="/dev/urandom";
my $TESTFILE="/home/rmoisa/somefile";

sub get_used_mem{
        my $ret="+-----------------+\n";
        open(my $file, '<' ,"/proc/$$/status");
        while (<$file>){
                chomp $_;
                if ($_ =~ /(^VmSize:(.+)$|^VmPeak:(.+)$|^Pid:(.+)$|^PPid:(.+)$|^Name:(.+)$|^SleepAVG:(.+)$|^Threads:(.+)$)/){
                        $_=~s/\s+/ /;
                        $ret.="$_\n";
                }
        }
        close($file);
        $ret.="+-----------------+";
        chomp $ret;
        return $ret;
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
my $md5 = Digest::MD5->new;
$md5->add($var);
print $md5->hexdigest."\n";
print &get_used_mem."\n";

`dd if=/dev/urandom of=$TESTFILE count=10M count=30`;
$var=`cat $TESTFILE`;
#undef $md5;
$md5->add($var);
print $md5->hexdigest."\n";
print &get_used_mem."\n";

