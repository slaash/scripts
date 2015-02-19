import sys
import os
import time
import sysinfo
import e32

sys.stdout.write("IMEI: %s\n" % sysinfo.imei())

sys.stdout.write("Battery strength: %s\n" % sysinfo.battery())
 
sys.stdout.write("Signal strength: %s\n" % sysinfo.signal_bars())
 
sys.stdout.write("Network signal strength in dBm: %s\n" % sysinfo.signal_dbm())
 
sys.stdout.write("SW version: %s\n" % sysinfo.sw_version())
 
sys.stdout.write("Display size:\n")
print(sysinfo.display_pixels())
 
sys.stdout.write("Current profile: %s\n" % sysinfo.active_profile())
 
sys.stdout.write("Ringing type: %s\n" % sysinfo.ring_type())
 
sys.stdout.write("OS version:\n")
print(sysinfo.os_version())

sys.stdout.write("Free/total RAM (MB): %.2f / %.2f\n" % (sysinfo.free_ram()/1024/1024,sysinfo.total_ram()/1024/1024))
 
sys.stdout.write("Total ROM (MB): %.2f \n" % (sysinfo.total_rom()/1024/1024))
 
sys.stdout.write("Free disk space C/E (MB): %.2f / %.2f\n" % (sysinfo.free_drivespace()['C:']/1024/1024,sysinfo.free_drivespace()['E:']/1024/1024))

sys.stdout.write("Python version: %s (%s, %s)\n" % (e32.pys60_version,e32.pys60_version_info[0],e32.pys60_version_info[1]))
 
sys.stdout.write("Symbian version: (%s, %s)\n" % (e32.s60_version_info[0],e32.s60_version_info[1]))
 
sys.stdout.write("Available drives: \n")
print(e32.drive_list())
 
sys.stdout.write("Inactivity time: %s\n" % e32.inactivity())
 
sys.stdout.write("Platf. sec. capabilities: \n")
print(e32.get_capabilities())

sys.stdout.write("Check WriteUserData: %s\n" % e32.has_capabilities(['WriteUserData']))
 
sys.stdout.write("Check WriteUserData and ReadUserData: "+str(e32.has_capabilities(['WriteUserData','ReadUserData']))+"\n")
 
sys.stdout.write("Check if UI thread: %s\n" % e32.is_ui_thread())
 
sys.stdout.write("Check if in emulator: %s\n" % e32.in_emulator())

sys.stdout.write("Current time: %s\n" % time.strftime("%a, %d %b %Y, %H:%M:%S", time.localtime()))

sys.stdout.write("Curent dir: %s\n" % os.getcwd())
