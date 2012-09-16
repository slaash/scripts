import os
import android

class fileListDiag():

	def __init__(self,dir=os.getcwd()):
		self.droid=android.Android()
		self.startDir=dir

	def cd(self,dir):
		try:
			os.chdir(dir)
		except OSError, e:
			self.droid.makeToast('Could not chdir: '+str(e))

	def makeListDiag(self,name,list):
		self.droid.dialogCreateAlert(name)
		self.droid.dialogSetNegativeButtonText('Cancel')
		self.droid.dialogSetItems(list)
		self.droid.dialogShow()
		return(self.droid.dialogGetResponse().result)

	def mainMenu(self):
	#	curDir=os.path.abspath(os.curdir)
		curDir=os.getcwd()
		items=['..']+sorted(os.listdir(curDir))
		answ=self.makeListDiag(curDir,items)
		print(answ)
		if (answ.get('canceled') == True or answ.get('which') == 'negative' ):
			exit(0)
		else:
			selection=os.path.join(curDir,items[answ['item']])
			self.itemAction(selection)

	def itemAction(self,item):
		if (os.path.isdir(item)):
			self.cd(item)
		elif (os.path.isfile(item)):
			self.fileAction(item)
		else:
			print('Not file or dir...')
			self.droid.makeToast(item)

	def fileAction(self,file):
		pass

	def run(self):
		self.cd(self.startDir)
		while (True):
			self.mainMenu()
