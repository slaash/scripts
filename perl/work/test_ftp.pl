#!/usr/bin/perl

use strict;
use warnings;

do "ftpfunc_new.pl";

chdir "/home/slash";

&upload_file("localhost","slash","nokia13","/tmp","1000MB");


