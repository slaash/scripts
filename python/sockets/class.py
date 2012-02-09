#!/usr/bin/python3

class mamaLuClass():

	motherOfAllKnowledge="aaa"

	def __init__(self):
		print("mommy init")
		motherOfAllKnowledge+="bbb"

	def doShit(self,txt):
		self.motherOfAllKnowledge+=txt

class classAlMic(mamaLuClass):
	def __init__(self):
		print("kiddie")
		print("Got var: ",self.motherOfAllKnowledge)

kiddie=classAlMic()
kiddie.doShit("sheise")
print(kiddie.motherOfAllKnowledge)

