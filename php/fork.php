#!/usr/bin/php
<?php
$pid=pcntl_fork();
if ($pid==0){
	print "Child!\n";
	foreach (range(1,100000) as $i){
	}
	exit;
}
else{
	print "Parent!\n";
}

print "Waiting for all guys to exit...\n";
pcntl_wait($status);

