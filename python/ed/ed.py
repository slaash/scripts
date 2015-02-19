#!/usr/bin/python

import sys
import tty
import termios

def getch():
	fd=sys.stdin.fileno()
	old_settings = termios.tcgetattr(fd)
	try:
		tty.setraw(sys.stdin.fileno())
		ch = sys.stdin.read(1)
	finally:
		termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
	return ch

def plan_to_exit():
	print('Bye!')
	exit(0)	



lines=['']
buff=''
crt_line=0

sys.stdout.write(str(crt_line)+": ")
sys.stdout.flush()
while(1):
	ch=getch()
	
	if (ord(ch) == 13):
		ch='\n'
		lines[crt_line]=buff
		crt_line=crt_line+1
		sys.stdout.write(str(crt_line)+": ")
		sys.stdout.flush()
		
	elif (ord(ch) == 3):
		plan_to_exit()
	else:
		buff=buff+ch

	sys.stdout.write(ch)
	sys.stdout.flush()

class line:

	def __init__(self,text):
		self.text=text

	@property
	def getText(self):
		return(self.text)

	def setText(self,text):
		self.text=text


class block():

	def __init__
