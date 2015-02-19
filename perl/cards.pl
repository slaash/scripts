#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my @cards=("A","2","3","4","5","6","7","8","9","10","J","Q","K");
my @card_types=("Trefla","Caro","Inima","Pica");

sub shuffle_cards{
	my @card_pack=@_;
	return @card_pack;
}

sub get_card_pack{
	my $packs_number=$_[0];
	my @card_pack;
	my %colour_set;
	my $card;
	my $card_type;
	for (my $i=0;$i<$packs_number;$i++){
		for $card_type (@card_types){
			for $card (@cards){
				$colour_set{$card}=$card_type;
			}
			push (@card_pack,{%colour_set});
		}
	}
	return @card_pack;	
}

sub show_pack{
	my @card_pack=@_;
	my $pack;
	for $pack (@card_pack){
		for (keys %$pack){
			print "$_($$pack{$_})\n";
		}
	}
}

sub get_first_card{
	my @card_pack=@_;
        my $pack;
	my %first_card;
	my $found=0;
        for $pack (@card_pack){
		if ($found==0){
                	for (keys %$pack){
				if ($found==0){
					if ($$pack{$_} ne "Deleted"){
                        			$first_card{$_}=$$pack{$_};
						$$pack{$_}="Deleted";
						$found=1;
						return %first_card;
					}
				}	
                	}
		}
        }
	return ("0"=>"0");
}

my @playing_cards=&shuffle_cards(&get_card_pack(1));

&show_pack(@playing_cards);

print "\n";

for (my $n=0;$n<100;$n++){
	print "Extragem o carte: ";
	my %f_c=&get_first_card(@playing_cards);
	if ($f_c{"0"} ne "0"){
		for (keys %f_c){
			print "$_($f_c{$_})\n";
		}
	}
}
