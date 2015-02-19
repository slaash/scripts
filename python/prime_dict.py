def is_prime(i):
	prim = 1
	for j in range(2, int(math.sqrt(i)+1)):
		if i % j == 0:
			prim = 0
			break
	if prim == 1:
		return true
	else:
		return false

for i in range(1,10):
	dict[i]=is_prime


