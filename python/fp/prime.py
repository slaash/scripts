#!/usr/bin/python

import math, sys

#def get_divisors(x):
#	return filter(lambda j: x % j == 0, range(2, int(math.sqrt(x)+1)))

#def is_prime(x):
#	if len(get_divisors(x)) == 0:
#	if len(filter(lambda j: x % j == 0, range(2, int(math.sqrt(x)+1)))) == 0:
#		return True

#def get_primes(min, max):
#	return filter(is_prime, range(min, max))

#print get_primes(1, 100)

#print filter(is_prime, range(1, 100))
print filter(lambda x: len(filter(lambda j: x % j == 0, range(2, int(math.sqrt(x)+1)))) == 0, range(int(sys.argv[1]), int(sys.argv[2])))

