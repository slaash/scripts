#!/opt/perl/bin/perl
#
#use parameter <nohistory> for reduced list


use strict;
use warnings;

my $DEBUG=0;
my %list;
my $line;
my @l;
my $nohist=0;

#return 0 for non-existing user, 1 for existing user
sub check_user{
	my $name=$_[0];
	my $user;
	if ($DEBUG==1){print "verific $name...";}
	my $gasit=0;
	foreach $user (keys %list){
		if ($user eq $name){
			$gasit=1;
			last;
		}
	}
	if ($gasit==0){
		if ($DEBUG==1){print "nu este.\n";}
		return 0;
	}
	else{
		if ($DEBUG==1){print "este deja!\n";}
		return 1;
	}
}

#adds user to list with 1 license
sub add_user{
	my $name=$_[0];
	$list{$name}=1;
	if ($DEBUG==1){print "\tadaugat user $name\n\tlicente: $list{$name}\n";}
}

#removes user from list (usefull when licenses number reaches zero)
sub del_user{
	my $name=$_[0];
	delete $list{$name};
	if ($DEBUG==1){print "\t\t=> sters user $name !\n";}
}
		

#increments number of licenses for user
sub add_lic{
	my $name=$_[0];
	my $user;
	foreach $user (keys %list){
		if ($user eq $name){
			$list{$user}+=1;
			if ($DEBUG==1){print "\tincrementat licente pentru $user\n\tlicente: $list{$user}\n";}
			last;
		}
	}
}

#decrements number of licenses for user
sub dec_lic{
	my $name=$_[0];
	my $user;
	foreach $user (keys %list){
		if ($user eq $name){
			if ($list{$user} > 0){
				$list{$user}-=1;
				if ($DEBUG==1){print "\tdecrementat licente pentru $user\n\tlicente: $list{$user}\n";}
				if ($list{$user} == 0 and $nohist == 1){
					&del_user($user);
				}
			}
			else{
				if ($DEBUG==1){print "\teroare la decrementare pentru $user\n";}
			}
			last;
		}
	}
}

sub dump_list{
	my $user;
	my $name;
	my $tot_lic=0;
	my $index=0;
	print "Nr.\tLicenses\tUser\n";
	print "-------------------------------------\n";
	foreach $user (keys %list){
		$index++;
		$tot_lic+=$list{$user};
		$name=`ypcat passwd|grep \"^$user\"|cut -d ':' -f 5|cut -d ',' -f 1`;
		chomp($name);
		print "$index:\t$list{$user}\t$name ($user)\n";
	}
	print "------- $tot_lic ---------------------------\n";
}

if ($#ARGV+1 > 0){
	if ($ARGV[0] eq "nohistory"){
		$nohist=1;
	}
}

open CMD,"grep -E -e \"IN\" -e \"OUT\" /db/is/ccm/65ccm_root_home/licensing.log|sed 's/^ //'|tr -s ' '|cut -d ' ' -f 1,3,4,6|";
while ($line=<CMD>){
	chomp $line;
	$line =~ s/[\[\]\"]//g;
	@l=split(/ /,$line);
	if ($l[1] eq "OUT:" and $l[2] eq "SYNERGY-CMBase"){	#daca a fost data licenta
		if ( &check_user($l[3]) == 0){	#si userul nu exista
			&add_user($l[3]);	#adauga userul cu o licenta
		}
		else{				#daca userul exista
			&add_lic($l[3]);	#incrementeaza-i numarul de licente
#			&dump_list;
		}
	}
		if ($l[1] eq "IN:" and $l[2] eq "SYNERGY-CMBase"){	#daca a fost returnata o licenta
		if ( &check_user($l[3]) == 0){	#si userul nu exista
			print "error: userul $l[3] a returnat licenta fara sa o fi primit !\n"	#tipa !
		}
		else{				#daca userul exista
			&dec_lic($l[3]);	#decrementeaza-i numarul de licente
#			&dump_list;
		}
	}
}
close CMD;

&dump_list;
