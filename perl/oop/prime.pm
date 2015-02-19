package prime;

sub new{
#usage:new(n)
	my $self=shift;
	$self->{n}=$_[0];
	$self->{prim}=undef;
	bless({$self});
	return $self;
}

sub is_prime{
#checks if n is prime, sets prime on return
	my ($self)=shift;
        my $x=$self->{n};
        $self->{prim}=1;
        for (my $j=2;$j<=sqrt($x);$j++){
                if ($x%$j==0){
                        $self->{prim}=0;
                        last;
                }
        }
	return $self->{prim};
}

1;

