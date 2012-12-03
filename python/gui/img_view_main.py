#!/usr/bin.python

from PyQt4 import QtCore, QtGui
from img_view_gui import Ui_MainWindow
import sys, time, os.path
import cv

class MyForm(QtGui.QMainWindow):

	def __init__(self,parent=None):
		QtGui.QWidget.__init__(self,parent)
		self.ui=Ui_MainWindow()
		self.ui.setupUi(self)
		self.ui.pushButton.clicked.connect(self.displayImg)
		self.ui.pushButton_2.clicked.connect(self.showFace)

	def displayImg(self):
		self.imgFile=self.getOpenDialogRes()
		if (self.imgFile != ''):	
			self.ui.label.setPixmap(QtGui.QPixmap(self.imgFile).scaled(self.ui.label.size(), QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation))

	def getOpenDialogRes(self):
		filename=QtGui.QFileDialog.getOpenFileName(None, "Select image", "", "*.*", None)
		return filename

	#begin OpenCV part

	def showFace(self):
		print(self.imgFile)
		im=cv.LoadImageM(self.imgFile)
		print("W/H: {}/{}".format(*cv.GetSize(im)))
		#resize to 800x???
		if (args.nores==False):
			im=resizeImg(im)
		#
		faces=cv.HaarDetectObjects(im,hc,cv.CreateMemStorage(),1.2,2,cv.CV_HAAR_DO_CANNY_PRUNING)
		for (x,y,w,h),n in faces:
			cv.Rectangle(im,(x,y),(x+w,y+h),255)
		cv.ShowImage('display',im)
		c=cv.WaitKey(0)
		print('Pressed '+str(c))
		if (c==1048603):
			exit(0)

	#end OpenCV part

haarPath='/usr/share/opencv/haarcascades'
hc=cv.Load(os.path.join(haarPath,'haarcascade_frontalface_default.xml'))

app=QtGui.QApplication(sys.argv)
myapp=MyForm()
myapp.show()
sys.exit(app.exec_())
 
