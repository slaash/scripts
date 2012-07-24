import android
import time

def lightsOut(droid,tstamp):
	actionTime=time.ctime(tstamp/1000000)
	print(actionTime+': Screen off')
	stopWifiIfEnabled(droid)
	level=droid.batteryGetLevel().result
	print('Batt level: '+str(level))
	droid.notify('Screen off',actionTime)

def lightsOn(droid,tstamp):
	actionTime=time.ctime(tstamp/1000000)
	print(actionTime+': Screen on')
	level=droid.batteryGetLevel().result
	print('Batt level: '+str(level))
	startWifiIfDisabled(droid)
	droid.notify('Screen on',actionTime)

def startWifiIfDisabled(droid):
	wifiState=droid.checkWifiState().result
	if (wifiState == False):
		print('Wifi disabled, enabling...')
		toggleWifi=droid.toggleWifiState().result
		if (toggleWifi == True):
			print('Wifi enabled')
	else:
		print('Wifi already enabled')

def stopWifiIfEnabled(droid):
	wifiState=droid.checkWifiState().result
	if (wifiState == True):
		print('Wifi enabled, disabling...')
		toggleWifi=droid.toggleWifiState().result
		if (toggleWifi == False):
			print('Wifi disabled')
	else:
		print('Wifi already disabled')

droid=android.Android()

droid.eventRegisterForBroadcast('android.intent.action.SCREEN_ON')
droid.eventRegisterForBroadcast('android.intent.action.SCREEN_OFF')

droid.batteryStartMonitoring()
time.sleep(1)

while True:
	actionData=droid.eventWait()
	action=actionData[1]['data']
	tstamp=actionData[1]['time']
	if (action == '{"action":"android.intent.action.SCREEN_OFF"}'):
		lightsOut(droid,tstamp)
	elif (action == '{"action":"android.intent.action.SCREEN_ON"}'):
		lightsOn(droid,tstamp)