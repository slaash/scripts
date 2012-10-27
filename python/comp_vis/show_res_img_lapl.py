#!/usr/bin/python

import cv
import os

pozePath=os.path.join(os.environ['HOME'],'poze')

for img in os.listdir(pozePath):
	imgPath=os.path.join(pozePath,img)
	print(imgPath)
	im=cv.LoadImageM(imgPath)
	resImg=cv.CreateMat(im.rows/5,im.cols/5,cv.CV_8UC3)
        cv.Resize(im,resImg)
	dst=cv.CreateImage(cv.GetSize(im),cv.IPL_DEPTH_16S,3)
	laplace=cv.Laplace(im,dst)
	cv.ShowImage('display',dst)
	cv.WaitKey(0)

