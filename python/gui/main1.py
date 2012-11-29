#!/usr/bin.python

from PyQt4 import QtCore, QtGui
from gui1 import Ui_MainWindow
import sys, time

class MyForm(QtGui.QMainWindow):

	def __init__(self,parent=None):
		QtGui.QWidget.__init__(self,parent)
		self.ui=Ui_MainWindow()
		self.ui.setupUi(self)
#		QtCore.QObject.connect(self.ui.pushButton, QtCore.SIGNAL("clicked()"), self.show_numbers)
		self.ui.pushButton.clicked.connect(self.show_numbers)
		self.ui.listWidget.itemClicked.connect(self.get_list_item)
#		QtCore.QObject.connect(self.ui.pushButton_2, QtCore.SIGNAL("clicked()"), self.update_list_item)
		self.ui.pushButton_2.clicked.connect(self.update_list_item)
#		QtCore.QObject.connect(self.ui.lineEdit_2, QtCore.SIGNAL("returnPressed()"), self.add_entry)

	def show_numbers(self):
		for i in range(int(self.ui.lineEdit.text()),int(self.ui.lineEdit_2.text())):
			self.ui.textBrowser.append(str(i))
			self.ui.listWidget.addItem(str(i))
			self.ui.lcdNumber.intValue=i
			self.ui.lcdNumber.display(str(i))
			time.sleep(1)

	def get_list_item(self):
		self.ui.lineEdit_3.setText(self.ui.listWidget.currentItem().text())

	def update_list_item(self):
		pass

app=QtGui.QApplication(sys.argv)
myapp=MyForm()
myapp.show()
sys.exit(app.exec_())
 
