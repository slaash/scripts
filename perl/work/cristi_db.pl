#!/usr/bin/perl -w
use warnings;
use strict;
use DBI;
use POSIX qw(strftime);
use Text::CSV;
use File::Copy;

my $database = "pr_reports";
my $hostname = "vmm02.ia.ro.conti.de";
my $user     = "pr_reports";
my $passwd   = "pr_reports";
my $sqlstring = '';
my $sth;

my $dbh = DBI->connect( "DBI:mysql:database=$database;host=$hostname", "$user", "$passwd", { 'RaiseError' => 1 } );

#$sqlstring = " select id_install from installation as a where a.install_date = (select max(b.install_date) from installation as b where b.id_tool = a.id_tool and b.id_user = a.id_user ) group by a.id_install order by a.id_tool,a.id_user asc";
$sqlstring = "select * from installation";
$sth = $dbh->prepare($sqlstring);
$sth->execute();

my $count = 0;
while (my $ref = $sth->fetchrow_hashref()) {
print $ref->{'id_install'} . ",";
$count++;
}
print "\n" . $count . "\n";
$dbh->disconnect();
