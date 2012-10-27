#!/usr/bin/python

import cv
import os

pozePath=os.path.join(os.environ['HOME'],'poze')

for img in os.listdir(pozePath):
	imgPath=os.path.join(pozePath,img)
	print(imgPath)
	im=cv.LoadImageM(imgPath)
	print("W/H: {}/{}".format(*cv.GetSize(im)))
	print("R/C: {}/{}".format(im.cols,im.rows))

