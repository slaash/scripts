#!/usr/bin/perl

use strict;
use warnings;

use 5.010;

use File::Basename;
use File::Spec;

say File::Spec->catfile(dirname($0), "xxx.pl");

