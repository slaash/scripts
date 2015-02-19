import android
import socket
import struct
import time

def getYesNo(droid):
	droid.dialogCreateAlert('Enable Wifi','Do you want to enable Wifi?')
	droid.dialogSetPositiveButtonText('Yes')
	droid.dialogSetNegativeButtonText('No')
	droid.dialogShow()
	return(droid.dialogGetResponse().result['which'])

def doScan(droid):
	scanStarted=droid.wifiStartScan()
	time.sleep(3)
	apList=[]
	for item in droid.wifiGetScanResults().result:
		ssid=item['ssid']
		apList.append(ssid)
	return(apList)
	
def getIP(droid):
	ipdec=droid.wifiGetConnectionInfo().result['ip_address']
	ipstr=socket.inet_ntoa(struct.pack('L',ipdec))
	return(ipstr)
	
droid=android.Android()

wifiState=droid.checkWifiState().result

if (wifiState == False):
	print('Wifi not enabled!')
	if (getYesNo(droid) == 'positive'):
		toggleWifi=droid.toggleWifiState().result
		if (toggleWifi == True):
			print('Wifi enabled')
	else:
		print('Not enabling Wifi')
		exit(0)

ip=getIP(droid)
print(ip)
if (ip == '0.0.0.0'):
	print('Reassociating...')
	droid.wifiReconnect()

aps=doScan(droid)
for a in aps:
	print(a)

