#!/usr/bin/perl

use Crypt::GeneratePassword qw(word);

for ($i=0;$i<10;$i++){
	$pass=word(20,20);
	print "$pass\n";
}
