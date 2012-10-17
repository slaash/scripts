#!/usr/bin/python

from PyQt4 import QtGui,QtCore
import sys

class myWidget(QtGui.QMainWindow):
	def __init__(self):
		super(myWidget,self).__init__()
		self.initUI()

	def initUI(self):
		self.setGeometry(300,300,500,400)	
		self.setWindowTitle('Test app')
		
		btn=QtGui.QPushButton('Push me!',self)
		btn.setToolTip('You push it...')
#		btn.clicked.connect(QtCore.QCoreApplication.instance().quit)
		btn.clicked.connect(self.customEvent)
		btn.resize(btn.sizeHint())
		btn.move(0,30)

		self.statusBar()

		pushMeAction=QtGui.QAction('Push me',self)
		pushMeAction.triggered.connect(self.customEvent)

		menubar=self.menuBar()
		fileMenu=menubar.addMenu('File')
		fileMenu.addAction(pushMeAction)

		self.show()

	def closeEvent(self,event):
		reply=QtGui.QMessageBox.question(self,'Msg','You sure you wanna quit?',QtGui.QMessageBox.Yes|QtGui.QMessageBox.No,QtGui.QMessageBox.No)
		if reply==QtGui.QMessageBox.Yes:
			event.accept()
		else:
			event.ignore()

	def customEvent(self,event):
		sender=self.sender()
		self.statusBar().showMessage(sender.text()+' was pressed')

app=QtGui.QApplication(sys.argv)
mw=myWidget()

app.exec_()

