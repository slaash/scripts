#!/usr/bin.python

from PyQt4 import QtCore, QtGui
from img_view_gui import Ui_MainWindow
import sys, time

class MyForm(QtGui.QMainWindow):

	def __init__(self,parent=None):
		QtGui.QWidget.__init__(self,parent)
		self.ui=Ui_MainWindow()
		self.ui.setupUi(self)
		self.ui.pushButton.clicked.connect(self.displayImg)

	def displayImg(self):
		imgFile=self.getOpenDialogRes()
		if (imgFile != ''):	
			self.ui.label.setPixmap(QtGui.QPixmap(imgFile).scaled(self.ui.label.size(), QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation))

	def getOpenDialogRes(self):
		filename=QtGui.QFileDialog.getOpenFileName(None, "Select image", "", "*.*", None)
		return filename

app=QtGui.QApplication(sys.argv)
myapp=MyForm()
myapp.show()
sys.exit(app.exec_())
 
