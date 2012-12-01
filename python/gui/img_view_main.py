#!/usr/bin.python

from PyQt4 import QtCore, QtGui
from img_view_gui import Ui_MainWindow
import sys, time

class MyForm(QtGui.QMainWindow):

	def __init__(self,parent=None):
		QtGui.QWidget.__init__(self,parent)
		self.ui=Ui_MainWindow()
		self.ui.setupUi(self)
		self.ui.label.geometry.Width=self.frame.geometry.Width
                self.ui.label.geometry.Height=self.frame.geometry.Height
		self.ui.pushButton.clicked.connect(self.displayImg)

	def displayImg(self):
		self.ui.label.setPixmap(QtGui.QPixmap('/home/slash/poze/IMG_0029.JPG').scaled(self.ui.label.size(), QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation))

app=QtGui.QApplication(sys.argv)
myapp=MyForm()
myapp.show()
sys.exit(app.exec_())
 
