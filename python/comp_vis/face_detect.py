#!/usr/bin/python

import cv
import os,sys
import argparse

def resizeImg(im):
	print('Resizing...')
	(pw,ph)=cv.GetSize(im)
	r=0
	if (pw>=ph):
		r=pw/800
	else:
		r=ph/600
	resImg=cv.CreateMat(im.rows/r,im.cols/r,cv.CV_8UC3)
	cv.Resize(im,resImg)
	print("W/H: {}/{}".format(*cv.GetSize(resImg)))
	return(resImg)

def showFace(poza):
	print(poza)
	im=cv.LoadImageM(poza)
	print("W/H: {}/{}".format(*cv.GetSize(im)))
	#resize to 800x???
	if (args.nores==False):
		im=resizeImg(im)
	#
	faces=cv.HaarDetectObjects(im,hc,cv.CreateMemStorage())
	for (x,y,w,h),n in faces:
		cv.Rectangle(im,(x,y),(x+w,y+h),255)
	cv.ShowImage('display',im)
	cv.WaitKey(0)

parser=argparse.ArgumentParser(description='Finds all faces in images.')
parser.add_argument('images',metavar='I',type=str,nargs='+',help='files')
parser.add_argument('--nores', action='store_true', help='Do not resize image.')
args=parser.parse_args()

haarPath='/usr/share/opencv/haarcascades'
hc=cv.Load(os.path.join(haarPath,'haarcascade_frontalface_default.xml'))

for img in args.images:
        showFace(img)
