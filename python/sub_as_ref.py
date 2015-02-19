#!/usr/bin/python

def get_timestamp(name):
	return 1

def do_stuff_to_name(name):
	return name

def lie_about_age(name):
	return name

values={
	"id" : get_timestamp,
	"name" : do_stuff_to_name,
	"age" : lie_about_age
}

for key in values.keys():
	print(values[key]("gigi"))

