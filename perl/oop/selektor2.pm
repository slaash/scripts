package selektor;

sub new{
#usage: new(<0|1>,("gigi","vali","simi"));
	my ($self)=shift;
	@{$self->{list}}=@_;
	bless({$self});
	return $self;
}

sub getNames{
#returns list of names
	my ($self)=shift;
	return @{$self->{list}};
}

sub shuffleArray{
	my ($self)=shift;
	my @arr=@{$self->{list}};
	for (my $i=0;$i<=$#arr;$i++){
		$tmp=$arr[$i];
		$randPos=rand($#arr+1);
		$arr[$i]=$arr[$randPos];
		$arr[$randPos]=$tmp;
	}
	@{$self->{list}}=@arr;
}

sub shiftArray{
	my ($self)=shift;
	my @arr=@{$self->{list}};
	for (my $i=1;$i<=$#arr;$i++){
		push(@new_arr,$arr[$i]);
	}
	push(@new_arr,$arr[0]);
	@{$self->{list}}=@new_arr;
}

1;

