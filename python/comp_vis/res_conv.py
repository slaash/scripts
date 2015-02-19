#!/usr/bin/python

import cv
import os

pozePath=os.path.join(os.environ['HOME'],'poze')

for img in os.listdir(pozePath):
	imgPath=os.path.join(pozePath,img)
	print(imgPath)
	im=cv.LoadImageM(imgPath)
	print(type(im))
	resImg=cv.CreateMat(im.rows/2,im.cols/2,cv.CV_8UC3)
	cv.Resize(im,resImg)
	resImgPath=os.path.join(pozePath,img+'_res')
	cv.SaveImage(resImgPath,resImg)
