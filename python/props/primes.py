#!/usr/bin/python

import math
import sys

class PrimeChecker():

	def __init__(self, x):
		self.x = x

	def is_x_prime(self):
		prim = 1
		for j in range(2, int(math.sqrt(self.x)+1)):
			if self.x % j == 0:
				prim = 0
				break
		if prim == 1:
			return True

	def get_x(self):
		return self.x

class PrimesFactory():

	primes=[]

	def __init__(self, x = 1, y = 10):
		self.x = x
		self.y = y
	
	def show(self):
		a=[]
		for n in range(self.x, self.y):
			a.append(PrimeChecker(n))
		for e in a:
			if e.is_x_prime() == True:
				print(e.get_x())

primes=PrimesFactory(int(sys.argv[1]), int(sys.argv[2]))
primes.show()

