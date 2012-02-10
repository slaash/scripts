#!/usr/bin/python3

import sys

class mamaLuClass():

	motherOfAllKnowledge="aaa"

	def __init__(self):
		print("mommy init")

	def doShit(self,txt):
		self.motherOfAllKnowledge="Mommy knows best: "+self.motherOfAllKnowledge+txt

	def __del__(self):
		print("bye bye "+self.__class__.__name__);

class classAlMic(mamaLuClass):
	def __init__(self):
		print("kiddie init")
		print("Got var: ",self.motherOfAllKnowledge)

	def doKiddieShit(self,txt):
		self.doShit("yyy")
		self.motherOfAllKnowledge="Stupid rebel kid: "+self.motherOfAllKnowledge+txt

class classAlMicSiDestept(mamaLuClass):
        def __init__(self):
                print("wise kiddie init")
                print("Got var: ",self.motherOfAllKnowledge)

        def doShit(self,txt):
                self.motherOfAllKnowledge="Wise kid: "+self.motherOfAllKnowledge+txt

#mommy=mamaLuClass()
#mommy.doShit("ccc")
#print(mommy.motherOfAllKnowledge)
#print("-------------------------")
#kiddie=classAlMic()
#kiddie.doShit("bbb")
#print(kiddie.motherOfAllKnowledge)
#kiddie.doKiddieShit("kkk")
#print(kiddie.motherOfAllKnowledge)
#print("-------------------------")
wisekid=classAlMic()
wisekid.doKiddieShit("kkk")
print(wisekid.motherOfAllKnowledge)
print("-------------------------")
newwiserkid=classAlMicSiDestept()
newwiserkid.doShit("xxx")
print(newwiserkid.motherOfAllKnowledge)

print("\npress a key...")
sys.stdin.readline()
