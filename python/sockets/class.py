#!/usr/bin/python3

class mamaLuClass():

	motherOfAllKnowledge="aaa"

	def __init__(self):
		print("mommy")
		self.motherOfAllKnowledge="aaa"

	def run(self):
		print("Set var to:",self.motherOfAllKnowledge)


class classAlMic(mamaLuClass):
	def __init__(self):
		print("kiddie")

	def run(self):
		print("Got var: ",self.motherOfAllKnowledge)

kiddie=classAlMic()

