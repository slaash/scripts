#!/usr/bin/python

import pi3d
import time

disp = pi3d.Display.create()
keys = pi3d.Keyboard()
shader = pi3d.Shader("2d_flat")
t=pi3d.Texture('/home/pi/tmp/IMG_0015.JPG', blend=True, mipmap=True)
c=pi3d.Canvas()
c.set_texture(t)
c.draw()

while disp.loop_running():
	k=keys.read()
	if k==27:
		disp.stop()	

disp.destroy()


