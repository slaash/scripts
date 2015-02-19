#!/usr/bin/perl

use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $string="d0774d789a269a3361e4edd87aee2596";

my $parallel = 5;
my $running = 0;
my $result;

$SIG{CHLD}="IGNORE";

sub compare{
	my $string=$_[0];
	my $phrase=$_[1];

	my $phrase_md5=md5_hex($phrase);
	if ($string eq $phrase_md5){
		print "Found: MD5($phrase)=$string\n";
		return 0;
	}
	else{
		return 1;
	}
}

my @chars=('a'..'z');
my @word;

for (@chars){
        $word[0]=$_;
        for (@chars){
                $word[1]=$_;
                for (@chars){
                        $word[2]=$_;
                        for (@chars){
                                $word[3]=$_;
				for (@chars){
					$word[4]=$_;
					for (@chars){
						$word[5]=$_;

		                                my $result=join('',@word);
#						print "$result\n";

						my $pid=fork;
						if ($pid==0){
							&compare($string,$result);
							exit;
						}
						else{
#							print "Runners: $running\n";
                					$running++;
                					if ($running >= $parallel) {
                        					$result = wait;
                        					$running--;
							}
                				}
					}
				}
			}
		}
	}
}

