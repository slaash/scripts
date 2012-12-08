#!/usr/bin.python

from PyQt4 import QtCore, QtGui
from img_view_gui import Ui_MainWindow
import sys, time, os.path
import cv

class WorkThread(QtCore.QThread):

	update=QtCore.pyqtSignal(cv.cvmat)

	def __init__(self,img,hc):
		QtCore.QThread.__init__(self)
		self.img=img
		print(str(self.img))
		self.hc=hc

	def resizeImg(self,im):
		print('Resizing...')
		(pw,ph)=cv.GetSize(im)
		print(pw,ph)
		r=0
		if (pw>=ph):
			r=pw/800
		else:
			r=ph/600
		resImg=cv.CreateMat(im.rows/r,im.cols/r,cv.CV_8UC3)
		cv.Resize(im,resImg)
		print("W/H: {}/{}".format(*cv.GetSize(resImg)))
		return(resImg)

	def run(self):
		im=cv.LoadImageM(str(self.img))
		print("W/H: {}/{}".format(*cv.GetSize(im)))
		#resize to 800x???
		im=self.resizeImg(im)
		#
		faces=cv.HaarDetectObjects(im,self.hc,cv.CreateMemStorage(),1.2,2,cv.CV_HAAR_DO_CANNY_PRUNING)
		for (x,y,w,h),n in faces:
			cv.Rectangle(im,(x,y),(x+w,y+h),255)
		#emit same type as defined for update
		self.update.emit(im)

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
#		self.hc=cv.Load(os.path.join(self.haarPath,'haarcascade_frontalface_default.xml'))
#		self.ui.label_4.setText(os.path.join(self.haarPath,'haarcascade_frontalface_default.xml'))

	def displayImg(self):
		self.getOpenDialogRes()
		if (self.imgFile != ''):	
			self.ui.label.setPixmap(QtGui.QPixmap(self.imgFile).scaled(self.ui.label.size(), QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation))
		if (self.hc==None):
			self.setHC()
		self.findFace()

	def getOpenDialogRes(self):
		self.imgFile=QtGui.QFileDialog.getOpenFileName(None, "Select image", "~/", "*.*", None)
		self.ui.label_4.setText(self.imgFile)

	def setHC(self):
		filename=QtGui.QFileDialog.getOpenFileName(None, "Select image", self.haarPath, "*.xml", None)
		if (filename!=''):
			self.hc=cv.Load(str(filename))
			self.ui.label_4.setText(filename)

	def findFace(self):
		print(self.imgFile,self.hc)
		self.workThread = WorkThread(self.imgFile,self.hc)
		self.workThread.update.connect(self.showFace)
		self.workThread.start()

	def showFace(self,im):
		image = QtGui.QImage(im.tostring(), im.width, im.height, QtGui.QImage.Format_RGB888).rgbSwapped()
		pixmap = QtGui.QPixmap.fromImage(image)
		self.ui.label_2.setPixmap(pixmap.scaled(self.ui.label_2.size(), QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation))	

app=QtGui.QApplication(sys.argv)
myapp=MyForm()
myapp.show()
sys.exit(app.exec_())
 
