#!/usr/bin/python

import pygame

pygame.init()

screen = pygame.display.set_mode()

img=pygame.image.load('/home/pi/tmp/IMG_0015.JPG')
imgrect=img.get_rect()

#screen.fill(black)

#while 1:
#	for event in pygame.event.get():
#		if event.type == pygame.QUIT: sys.exit()
screen.blit(img, imgrect)
pygame.display.flip()
raw_input()

