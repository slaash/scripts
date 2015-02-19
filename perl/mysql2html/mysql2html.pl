#!/usr/bin/perl

use warnings;
use strict;

use DBI;


my $dbh = DBI->connect("DBI:mysql:database=work;host=localhost",'slash', 'nokia13');
$dbh->do("drop table if exists files");
$dbh->do("create table files(id int auto_increment primary key,name varchar(255),size int)");
print "Created table files...\n";

opendir(my $dir,"/bin");
my @content=readdir($dir);
closedir($dir);

my $size;
for (@content){
	$size=(stat("/bin/$_"))[7];
	print "$_ => $size\n";
	$dbh->do("insert into files(name,size) values(\"$_\",\"$size\")");
}

print "Pattern: ";
my $pattern=<STDIN>;
chomp $pattern;
my $query=$dbh->prepare("select name,size from files where name like '%".$pattern."%'");
$query->execute();
while (my $ref=$query->fetchrow_hashref()){
	print "$ref->{'name'}\n";
}
$query->finish();

$dbh->disconnect();

