#!/usr/bin/python

def gen_f():
	memo = dict()
	def f(x):
		print("Got: "+str(x))
		try:
			return memo[x]
		except KeyError:
			memo[x] = x + 3
	return f

f = gen_f()
print(f(123))

