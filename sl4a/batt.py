import android
import time

droid=android.Android()

droid.batteryStartMonitoring()
time.sleep(1)

temp=droid.batteryGetTemperature().result

volt=droid.batteryGetVoltage().result

level=droid.batteryGetLevel().result

print("{0} {1} {2}".format(temp,volt,level))

allInfo=droid.readBatteryData()

print(allInfo)
