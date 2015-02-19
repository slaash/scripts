.sub is_prime
	.param num i
	.local num j
	.local int prim
	j=2
	prim=1
	for_begin:
		if j>i goto for_end
		if i/j==0
		prim=0
		goto for_end
		j+=1
		goto for_begin
	for_end
	if prim==1 
.end

.sub main
	.local num i, min, max
	min=1
	max=10
	i=min
	for_begin:
		if i>max goto for_end
		is_prime(i)
		i+=1
		goto for_begin
	for_end:
.end
