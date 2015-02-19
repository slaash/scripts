#!/usr/bin/perl

use strict;
use warnings;

use IPC::SysV qw(IPC_CREAT IPC_PRIVATE IPC_RMID S_IRUSR S_IWUSR IPC_RMID);

my $key=12345;
my $size=100;
my $msg="aaaa";
my $id = shmget(IPC_PRIVATE, $size, S_IRUSR|S_IWUSR);
$key=shmget($key,$size,&IPC_CREAT|0777);
shmwrite($id,$msg,0,80);

my $var="";
$key=12345;
my $new_id=shmget($key,$size,0777);
shmread($new_id,$var,0,$size);
print $var;

shmctl($id,&IPC_RMID,0);

