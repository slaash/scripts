package bitch;

use strict;
use warnings;

use 5.010;

sub new{
	my ($class)=@_;
	my $self={
		ma_name => undef,
		ma_place => undef
	};
	bless $self,$class;
	return $self;
}

sub ma_name{
	my ($self,$ma_name)=@_;
	$self->{ma_name}=$ma_name if defined($ma_name);
	return $self->{ma_name};
}

sub ma_place{
	my ($self,$ma_place)=@_;
	$self->{ma_place}=$ma_place if defined($ma_place);
	return $self->{ma_place};
}

sub whos_ma_bitch{
	my ($self)=@_;
	say $self->ma_name.", ".$self->ma_place;
}

1;

