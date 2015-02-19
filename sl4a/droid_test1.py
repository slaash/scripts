#!/usr/bin/python

import android
import sys

droid=android.Android()

droid.makeToast('There we go!')

text=droid.dialogGetInput('Say somethin\'').result
print(text)


sys.stdin.readline()

