#!/usr/bin/perl

sub file_to_mem{
#baga adp_db in memorie in $list
	open FILE,"<","arp_db";
	while ($file_line=<FILE>){
		chomp $file_line;
		@f_l=split(/ /,$file_line);
		$list{$f_l[0]}=$f_l[1];
	}
	close FILE;
}

sub mem_to_file{
#salveaza continutul $list in fisierul arp_db
	open FILE,">","arp_db";
        while (($adr,$mac)=each(%list)){
	        print FILE "$adr $mac\n";
        }
	close FILE;
}

sub show_mem{
#afiseaza ce este in $list
	while (($adr,$mac)=each(%list)){
        	print "$adr\t$mac\t".find_prod($mac)."\n";
	}
}

sub find_prod{
#are ca parametru un mac
#cauta in /usr/share/nmap/nmap-mac-prefixes
#returneaza producatorul
	@m=split(/:/,$_[0]);
	$mc=$m[0].$m[1].$m[2];
	$prod=`grep \"$mc\" /usr/share/nmap/nmap-mac-prefixes`;
	chomp $prod;
	if ($prod eq ""){
		$prod="       UNKNOWN";
	}
	return substr($prod,7);
}

sub pair_check{
#are ca argumente o adresa si un mac; le compara cu ce e in lista
#$adr si $mac sunt din list, adica din fisier
#$_[0] si $_[1] sunt parametrii trimisi functiei, adica valorile aratate de arp	
	print "checking $_[0] with mac $_[1] (".find_prod($_[1]).") ... ";
	$found=0;
        while (($adr,$mac)=each(%list)){
		if ($adr eq $_[0]){
			$found=1;
			if ($mac eq $_[1]){
				print "ok\n";
			}
			else {
				if ($mode eq "update"){
					$list{$adr}=$_[1];
					print "mac updated !\n";
				}
				else{
					if ($mode eq "new" and $mac eq "(incomplete)"){
						$list{$adr}=$_[1];
						print "incomplete mac updated !\n";
					}
					else{
						print "mac changed (not updated)\n";
					}
				}
			}
		}
	}
	if ($found==0){
		if ($mode eq "new"){
			$list{$_[0]}=$_[1];
			print "ip added !\n";
		}
		else{
			print "new ip (not added)\n";
		}
	}
}

if ($ARGV[0] eq "u"){
	$mode="update";
}
else{ 
	if($ARGV[0] eq "n"){
		$mode="new";
	}
	else{
		$mode="info";
		print "ARP Database\nusage: arpdb.pl <n>|<u>\nwhere n is for adding new ips or updating an incomplete record\n      u for updating the mac for an existing ip\n";
		print "new ip - generaly ok\n";
		print "update - BAD !!!\n";
		print "IT DOESN'T CHANGE ANYTHING WHEN RUN WITHOUT ANY OPTION...\n\n"
	}
}

&file_to_mem;
print "Mode: $mode\n\n";
print "System STATUS:\n";
open CMD,"/sbin/arp -n|";
while ($cmd_line=<CMD>){
	if ($cmd_line !~ /^Address/){
                chomp $cmd_line;
		if ($cmd_line !~ /incomplete/){
			@c_l=split(/\s+/,$cmd_line);
			&pair_check($c_l[0],$c_l[2]);
		}
		else{
                        @c_l=split(/\s+/,$cmd_line);
                        &pair_check($c_l[0],$c_l[1]);
		}
	}
}
close CMD;
if ($mode ne "info"){
	&mem_to_file;
}
print "\nFile STATUS:\n";
&file_to_mem;
&show_mem;

