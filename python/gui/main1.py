#!/usr/bin.python

from PyQt4 import QtCore, QtGui
from gui1 import Ui_MainWindow
import sys, time

class WorkThread(QtCore.QThread):

	update=QtCore.pyqtSignal(str)

	def __init__(self,txt1,txt2):
		QtCore.QThread.__init__(self)
		self.fromValue=int(txt1)
		self.toValue=int(txt2)

	def run(self):
		for i in range(self.fromValue,self.toValue):
			self.update.emit(str(i))
                        time.sleep(1)

class MyForm(QtGui.QMainWindow):

	def __init__(self,parent=None):
		QtGui.QWidget.__init__(self,parent)
		self.ui=Ui_MainWindow()
		self.ui.setupUi(self)
#		QtCore.QObject.connect(self.ui.pushButton, QtCore.SIGNAL("clicked()"), self.show_numbers)
		self.ui.pushButton.clicked.connect(self.update_lcd)
		self.ui.listWidget.itemClicked.connect(self.get_list_item)
		self.ui.pushButton_2.clicked.connect(self.update_list_item)
		self.lcdThreadPool=[]

	def show_numbers(self):
		for i in range(int(self.ui.lineEdit.text()),int(self.ui.lineEdit_2.text())):
			self.ui.textBrowser.append(str(i))
			self.ui.listWidget.addItem(str(i))

	def update_lcd(self):
		if (len(self.lcdThreadPool)>0):
			for t in self.lcdThreadPool:
				t.terminate()
				self.lcdThreadPool.pop()
		self.workThread = WorkThread(self.ui.lineEdit.text(),self.ui.lineEdit_2.text())
		self.lcdThreadPool.append(self.workThread)
		self.workThread.update.connect(self.really_update_lcd)
		self.workThread.start()

	def really_update_lcd(self, text="-1"):
		self.ui.lcdNumber.display(text)

	def get_list_item(self):
		self.ui.lineEdit_3.setText(self.ui.listWidget.currentItem().text())

	def update_list_item(self):
		pass

app=QtGui.QApplication(sys.argv)
myapp=MyForm()
myapp.show()
sys.exit(app.exec_())
 
