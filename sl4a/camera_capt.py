import os
import time
import android

droid=android.Android()

basedir=os.path.abspath(os.curdir)
tmpdir=os.path.join(basedir,'tmp')
print(basedir,tmpdir)

if (os.path.exists(tmpdir) == False):
	os.mkdir(tmpdir)

rez=droid.cameraInteractiveCapturePicture(os.path.join(tmpdir,str(int(time.time()))))
print(rez.result['takePicture'])
