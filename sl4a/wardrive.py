import android
import time

def doScan(droid):
	scanStarted=droid.wifiStartScan()
	time.sleep(3)
	for item in droid.wifiGetScanResults().result:
		bssid=item['bssid']
		ssid=item['ssid']
		level=item['level']
		caps=item['capabilities']
		freq=item['frequency']
		print(bssid,ssid,level,caps,freq)
	return(apList)

droid=android.Android()
doScan(droid)
