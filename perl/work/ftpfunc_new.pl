#!/usr/local/bin/perl -I/HOME/ccm_wet/local/scripts/msext/lib

use strict;
use warnings;
use Net::FTP;

#start_conn(<server>,<username>,<password>)
#returns connection to server
sub start_conn{
	my ($server,$user,$pass)=@_;
#	my $ftp = Net::FTP->new($server, Debug => 0, Passive=>0, Firewall=>'proxy.rb.de.conti.de', FirewallType=>1);
	my $ftp = Net::FTP->new($server, Timeout => 600, BlockSize => 1024) or die "Could not connect to server!";
	my $login;
	eval{
		$login=$ftp->login($user,$pass);
		print "Login: $login\n";
	};
	print $ftp->message();
	if ($login ne "1" or $@){
		print "Could not start FTP session\n";
		return undef;
	}
	else{
		return $ftp;
	}
}

sub upload_file{
        my ($server,$user,$pass,$dir,$file)=@_;
        my $max_tries=5;
        if (-e $file){
                my $ok=0;
                my $try=0;
                my $conn;
		$|=1;
                while ($ok==0 and $try<$max_tries){
			$conn=&start_conn("$server","$user","$pass");
			if ($conn){
	                        $conn->cwd($dir) or die "Could not change to remote directory $dir !\n";
        	                $conn->binary();
				my $rez;
				eval{
					print "Uploading $file...\n";
               	         		$rez=$conn->put("$file");
				};
				if ($@){
					print "Major failure uploading $file!\n";
					$try++;
				}
	                        if ($rez and $rez eq $file){
       	                        	print "Successfully uploaded file $file on try #$try\n";
       	                        	$ok=1;
	                        }
	                        else{
	                                print "Fail #$try uploading $file\n";
	                                $try++;
	                        }
			}
			else{
				exit;
			}	
                }
                &stop_conn($conn);
		$|=0;
                if ($ok==0){
                        print "Could not upload $file after $try tries!\n";
                        exit 1;
                }
        }
        else{
                print "Local file $file can not be accessed!\n";
                exit 1;
        }
}

#stop_conn(<connection>)
#closes the connection
sub stop_conn{
	my $conn=$_[0];
	$conn->quit();
}

sub get_ftp_files{
	my $server=$_[0];
	my $user=$_[1];
	my $pass=$_[2];
	my $folder=$_[3];
	my $conn=&start_conn("$server","$user","$pass");
        $conn->cwd($folder) or die "Could not change to remote directory $folder !\n";
        $conn->binary();
        my @files=$conn->ls("*");
	return @files;
}

sub download_file{
	my ($conn,$dir,$file)=@_;
	$conn->cwd($dir) or die "Could not change to remote directory $dir !\n";
	$conn->binary();
	my $local_size;
	my $rez;
	my $completed=0;
	if (-e $file){
		$local_size=(stat("$file"))[7];
		my $rem_size=$conn->size("$file");
		if ($local_size==$rem_size){
			print "File $file already downloaded\n";
			$completed=1;
		}
		elsif ($local_size<$rem_size){
#			$local_size=$local_size+1;
			print "File $file exists, restarting at $local_size\n";
		}
		elsif ($local_size>$rem_size){
			print "File $file looks bigger, we restart from 0\n";
			undef $local_size;
		}
	}
	
	if ($completed==0){
		if ($local_size){
			#Returns LOCAL_FILE, or the generated local file name if LOCAL_FILE is not given. If an error was encountered undef is returned.
			$rez=$conn->get($file,$file,$local_size);
		}
		else{
			$rez=$conn->get($file,$file);
		}
		if ($rez){
			if ($rez eq $file){
				return 0;
			}
			else{
				return -1;
			}
		}
		else{
			return -1;
		}
	}
	else{
		return 0;
	}
}

sub get_missing_files{
	my @array1=@{$_[0]};
	my @array2=@{$_[1]};
	my @missing;
	for my $a1 (@array1){
		my $found=0;
		for my $a2 (@array2){
			if ($a1 eq $a2){
				$found=1;
				last;
			}
		}
		if ($found==0){
			push(@missing,$a1);	
		}
	}
	return @missing;
}

sub download_all_files{
	my $server=$_[0];
	my $user=$_[1];
	my $pass=$_[2];
	my $folder=$_[3];
	my @ftp_files=&get_ftp_files("$server","$user","$pass","$folder");
	my @downloaded_files;
	my $max_tries=5;
	for my $file (@ftp_files){
        	my $ok=0;
	        my $try=0;
	        while ($ok==0 and $try<$max_tries){
	                my $conn=&start_conn("$server","$user","$pass");
        	        if (&download_file($conn,"$folder","$file") == 0){
                	        push (@downloaded_files,$file);
                        	print "Downloaded ok $file\n";
	                        $ok=1;
        	        }
	                else{
        	                print "Fail #$try downloading $file\n";
                	        $try++;
	                }
        	        &stop_conn($conn);
	        }
        	if ($ok == 0){
	                print "Removing incomplete file $file\n";
	               unlink $file;
	       }
	}
	my @missing_files=&get_missing_files(\@ftp_files,\@downloaded_files);
	return @missing_files;
}

print "ftpfunc ran successfully\n";


