import file_ops_base
import mimetypes
import re
import os

class filezToOpen(file_ops_base.fileListDiag):

	def moveFile(self,old,new):
		try:
			os.rename(old,new)
		except OSError, e:
			print('Could not move: ',e)
			exit(0)

	def massRename(self,toWhat):
		m=re.match(r"([a-zA-Z_]+)(\d+)(.[a-zA-Z]+)",toWhat)
		alpha=m.group(1)
		firstNum=int(m.group(2))
		ext=m.group(3)
		curDir=os.getcwd()
		crt=0
		self.droid.dialogCreateHorizontalProgress('Renaming files...',None,len(os.listdir(curDir)))
		self.droid.dialogShow()
		for item in sorted(os.listdir(curDir)):
			if (os.path.isfile(item) and re.match(alpha,item)):
				newName=alpha+"{0:0={1}}".format(firstNum,len(toWhat)-len(alpha)-len(ext))+ext
				while (os.path.exists(os.path.join(curDir,newName))):
					firstNum+=1
					newName=alpha+"{0:0={1}}".format(firstNum,len(toWhat)-len(alpha)-len(ext))+ext
				firstNum+=1
				self.moveFile(os.path.join(curDir,item),os.path.join(curDir,newName))
				crt+=1
				self.droid.dialogSetCurrentProgress(crt)
		self.droid.dialogDismiss()
		self.droid.makeToast('Done')

	def fileAction(self,file):
		print(file)
		m=re.match(r".+\/(.+)$",file)
		file=m.group(1)
		firstFile=self.droid.dialogGetInput('Enter first file name',None,file).result
		if (firstFile != None):
			print(firstFile)
			self.massRename(firstFile)
	
filez=filezToOpen('/sdcard/Pictures/poze vara 2012 tata/plaiul foii')
filez.run()
