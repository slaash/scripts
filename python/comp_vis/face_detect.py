#!/usr/bin/python

import cv
import os,sys
import argparse

def getMat(img):
	src=cv.LoadImageM(img)
	print(cv.GetMat(src))

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

def toGrey(img):
	src=cv.LoadImage(img)
	grey=cv.CreateImage((src.height,src.width),8,1)
	cv.CvtColor(src,grey,cv.CV_BGR2GRAY)
#	print("W/H: {}/{}".format(*cv.GetSize(grey)))
	cv.ShowImage('display',grey)

def equalImg(img):
	src=cv.LoadImageM(img)
	print(src.rows,src.cols)
	newImg=cv.CreateMat(src.rows,src.cols,cv.CV_8UC3)
	cv.EqualizeHist(src,newImg)
#	cv.ShowImage('display',newImg)

def showFace(poza):
	print(poza)
	im=cv.LoadImageM(poza)
	print("W/H: {}/{}".format(*cv.GetSize(im)))
	#resize to 800x???
	if (args.nores==False):
		im=resizeImg(im)
	#
	faces=cv.HaarDetectObjects(im,hc,cv.CreateMemStorage(),1.2,2,cv.CV_HAAR_DO_CANNY_PRUNING)
	for (x,y,w,h),n in faces:
		cv.Rectangle(im,(x,y),(x+w,y+h),255)
	cv.ShowImage('display',im)
	c=cv.WaitKey(0)
	print('Pressed '+str(c))
	if (c==1048603):
		exit(0)

parser=argparse.ArgumentParser(description='Finds all faces in images.')
parser.add_argument('images',metavar='I',type=str,nargs='+',help='files')
parser.add_argument('--nores', action='store_true', help='Do not resize image.')
args=parser.parse_args()

haarPath='/usr/share/opencv/haarcascades'
hc=cv.Load(os.path.join(haarPath,'haarcascade_frontalface_default.xml'))

for img in args.images:
#	toGrey(img)
#	showFace(img)
	getMat(img)
	equalImg(img)
