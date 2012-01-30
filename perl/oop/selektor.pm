package selektor;

sub new{
#usage: new(<0|1>,("gigi","vali","simi"));
	my $self=shift;
	$self->{verbose}=$_[0];
	shift;
	@{$self->{list}}=@_;
	$self->{shit}=1;
	@{$self->{orig_list}}=@{$self->{list}};
	bless({$self});
	return $self;
}

sub getNames{
#returns list of names
	my ($self)=shift;
	return @{$self->{list}};
}

sub genPairs{
	my ($self)=shift;
	while ($self->{shit}==1){
		@{$self->{list}}=@{$self->{orig_list}};
		for (@{$self->{list}}){
			print $self->remRandName($_)."\n";
		}
		print "---\n";
	}
	print "genPairs done\n";
}

sub remRandName{
#usage: remRandName("gigi")
#gets the element from a random position in the list
#delete the element from the list on the random position
#IF IT IS NOT IDENTICAL WITH THE SUPPLIED PARAMETER
	my ($self)=shift;
	my $namesInList=$#{$self->{list}}+1;
	my $randPos;
#if there are only two remaining in the list, compare with the supplied parameter and return the other element
	if ($namesInList == 2){
		if ($self->{verbose} == "1"){
			print "2 remaining... ";
		}
		if (${$self->{list}}[0] eq $_[0]){
			$randPos=1;
		}
		else{
			$randPos=0;
		}
		$delName=${$self->{list}}[$randPos];
		splice(@{$self->{list}},$randPos,1);#better than delete!
		return $delName;
	}
#if there is only one remaining in the list, return it
	elsif ($namesInList == 1){
		if ($self->{verbose} == "1"){
			print "1 remaining... ";
		}
		$randPos=0;
		$delName=${$self->{list}}[$randPos];
		if ($delName ne $_[0]){
			$self->{shit}=0;#this means that the last guy did not extract himself
		}
		splice(@{$self->{list}},$randPos,1);#better than delete!
		return $delName;
	}
	else{
		$randPos=int(rand($namesInList));
	}
	my $delName=${$self->{list}}[$randPos];
	while ($delName eq $_[0]){
		if ($self->{verbose} == "1"){
			print "$delName eq $_[0], extracting again... ";
		}
		$randPos=int(rand($namesInList));
		$delName=${$self->{list}}[$randPos];
	}
	splice(@{$self->{list}},$randPos,1);#better than delete!
	return $delName;
}

1;

