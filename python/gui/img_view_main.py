#!/usr/bin.python

from PyQt4 import QtCore, QtGui
from img_view_gui import Ui_MainWindow
import sys, time, os.path
import cv

class WorkThread(QtCore.QThread):

	finida=QtCore.pyqtSignal(QtGui.QImage)
	chatty=QtCore.pyqtSignal(str)
	
	def __init__(self,img,hc):
		QtCore.QThread.__init__(self)
		self.img=img
		self.chatty.emit("CV init {}".format(self.img))
		self.hc=hc

	def resizeImg(self,im):
		self.chatty.emit('Resizing...')
		(pw,ph)=cv.GetSize(im)
		self.chatty.emit("CV Resize {} {}".format(pw,ph))
		r=0
		if (pw>=ph):
			r=pw/800
		else:
			r=ph/600
		resImg=cv.CreateMat(im.rows/r,im.cols/r,cv.CV_8UC3)
		cv.Resize(im,resImg)
		self.chatty.emit("W/H: {}/{}".format(*cv.GetSize(resImg)))
		return(resImg)

	def run(self):
		im=cv.LoadImageM(str(self.img))
		self.chatty.emit("CV W/H: {}/{}".format(*cv.GetSize(im)))
		#resize to 800x???
		im=self.resizeImg(im)
		#
		faces=cv.HaarDetectObjects(im,self.hc,cv.CreateMemStorage(),1.2,2,cv.CV_HAAR_DO_CANNY_PRUNING)
		for (x,y,w,h),n in faces:
			cv.Rectangle(im,(x,y),(x+w,y+h),255)
		#emit same type as defined for update
		image = QtGui.QImage(im.tostring(), im.width, im.height, QtGui.QImage.Format_RGB888).rgbSwapped()
		self.finida.emit(image)
		self.chatty.emit('Done')

class MyForm(QtGui.QMainWindow):

	haarPath='/usr/share/opencv/haarcascades'

	def __init__(self,parent=None):
		QtGui.QWidget.__init__(self,parent)
		self.ui=Ui_MainWindow()
		self.ui.setupUi(self)
		self.ui.pushButton.clicked.connect(self.displayImg)
		self.ui.pushButton_2.clicked.connect(self.setHC)
		self.hc=None
		self.imgFile=''
		self.hc=cv.Load(os.path.join(self.haarPath,'haarcascade_frontalface_default.xml'))
		self.ui.label_4.setText(os.path.join(self.haarPath,'haarcascade_frontalface_default.xml'))
		self.logStatus("Is ready")
		self.stupidPrgBarUpd()

	def displayImg(self):
		res=self.getOpenDialogRes()
		if (res != ''):
			self.imgFile=res
			self.ui.label_3.setText(self.imgFile)
			self.setImageToLabel(self.imgFile,self.ui.label)
			self.findFace()

	def setHC(self):
		res=self.getOpenDialogRes("Select HAAR filter",self.haarPath,"*.xml")
		if (res!=''):
			self.hc=cv.Load(str(res))
			self.ui.label_4.setText(res)
			self.findFace()

	def findFace(self):
		if (self.hc==None):
			self.setHC()
		else:
			self.logStatus("FindFace {} {}".format(self.imgFile,self.hc))
			self.workThread = WorkThread(self.imgFile,self.hc)
			self.workThread.chatty.connect(self.logStatus)
			self.workThread.finida.connect(self.showFace)
			self.workThread.start()

	def showFace(self,image):
		self.setImageToLabel(image, self.ui.label_2)
		
	def setImageToLabel(self,image,label):
		label.setPixmap(QtGui.QPixmap(image).scaled(label.size(), QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation))
		
	def getOpenDialogRes(self,caption='Select file',startDir='',fileFilter='*.*'):
		res=QtGui.QFileDialog.getOpenFileName(None, caption, startDir, fileFilter, None)
		#returns path or ''
		return res
		
	def stupidPrgBarUpd(self):
		for i in range(0,101):
			self.ui.progressBar.setValue(i)
#			time.sleep(1)
		
	def logStatus(self,msg):
		self.ui.textEdit.append("{}: {}".format(time.strftime('%H:%M:%S'),msg))

app=QtGui.QApplication(sys.argv)
myapp=MyForm()
myapp.show()
sys.exit(app.exec_())
