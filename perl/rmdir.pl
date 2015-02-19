#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;

sub list {
    my $dir = shift @_;
    opendir( DIR, $dir ) || die "err: opendir failed: $!";

    #        grep not current dir or parent ( . and .. )
    my @ls = grep !/\.\.?$/, readdir(DIR);
    return @ls;
}

sub rm_tree {
    my $path = shift;
    my $ret;
    print $path. "\n";
    if ( -d $path ) {
        print "is dir..listing $path\n";
        &rm_tree( File::Spec->catfile( $path, $_ ) ) foreach &list($path);
        print "is dir..rem empty $path\n";
        rmdir $path or print "err: rmdir $path $!\n";
    }
    elsif ( -f $path ) {
        print "is file\n";
        unlink($path) or ( print "err: unlink $path $!\n" && return 1 );
    }
    else {
        print "err: unknown type $path $!\n";
        return 1;
    }
    return 0;
}

my $d_path = File::Spec->catfile("d","c","ss");
print "path ".$d_path."\n";
if ( rm_tree($d_path) ) {    #err
    print "err rm_tree $!\n";
}
else {                       #success
    print "ok\n";
}
