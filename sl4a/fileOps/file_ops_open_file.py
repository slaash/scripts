import file_ops_base
import mimetypes

class filezToOpen(file_ops_base.fileListDiag):

	def readTextFile(self,file):
		try:
			f=open(file,mode='r')
		except IOError, e:
			self.droid.makeToast('Could not open file: '+str(e))
			return 0
		for line in f:
			print(line.rstrip())
		print('Press Enter to continue...')
		raw_input()

	def fileAction(self,file):
		print(file)
		#self.droid.startActivity('android.intent.action.VIEW', file,'image/*')
		mType=mimetypes.guess_type(file)[0]
		if (mType==None):
			mType='text/plain'
		print(mType)
		if (mType=='text/plain'):
			self.readTextFile(file)
		else:
			self.droid.view('file://'+file, mType)
	
filez=filezToOpen('/proc')
filez.run()
