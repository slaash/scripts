import android
import sys

droid=android.Android()

def makeListDiag(name,list):
	droid.dialogCreateAlert(name)
	droid.dialogSetNegativeButtonText('Cancel')
	droid.dialogSetItems(list)
	droid.dialogShow()
	return(droid.dialogGetResponse().result)

def mainMenu():
	answ=makeListDiag('Select action',['App launcher','App killer'])
	if (answ.get('which') == 'None' or answ.get('which') != 'negative'):
		if (answ['item'] == 0):
			 appLauncher()
		elif (answ['item'] == 1):
			 appManager()
	else:
		sys.exit(0)

def appLauncher():
	appsDict=droid.getLaunchableApplications().result
	answ=makeListDiag('Select app to launch',appsDict.keys())
	if (answ.get('which') == 'None' or answ.get('which') != 'negative'):
		appno=answ['item']
		app=appsDict.keys()[appno]
		print(app)
		print(appsDict[app])
		droid.launch(appsDict[app])

def appManager():
	appsList=droid.getRunningPackages().result
	answ=makeListDiag('Select app to kill',appsList)
	if (answ.get('which') == 'None' or answ.get('which') != 'negative'):
		appno=answ['item']
		app=appsList[appno]
		print(app)
		print(droid.forceStopPackage(app))

while (True):
	mainMenu()
