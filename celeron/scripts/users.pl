#!/usr/bin/perl

print "VPN Address\tUser\tAddress:Port\t\tSince\n\n";
open FILE,"/etc/openvpn/openvpn-status.log";
while ($LINIE=<FILE>){
        chomp $LINIE;
        if ($LINIE=~/^\d+.\d+.\d+.\d+,\w+,\d+.\d+.\d+.\d+:\d+/){
                @L=split(/,/,$LINIE);
                print $L[0]."\t".$L[1]."\t".$L[2]."\t".$L[3]."\t".$L[4]."\n";
        }
}
close FILE;

