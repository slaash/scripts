package selektor;

sub new{
#usage: new(("gigi","vali","simi"));
	my $self=shift;
	@{$self->{list}}=@_;
	bless({$self});
	return $self;
}

sub getNames{
#returns list of names
	my ($self)=shift;
	return @{$self->{list}};
}

sub remRandName{
#delete an element from the names array from a random position
	my ($self)=shift;
	my $namesInList=$#{$self->{list}}+1;
	my $randPos=int(rand($namesInList));
	my $delName=${$self->{list}}[$randPos];
	splice(@{$self->{list}},$randPos,1);#better than delete!
	return $delName;
}

1;

