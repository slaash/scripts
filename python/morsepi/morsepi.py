#!/usr/bin/python

import readchar
import os
from time import sleep

UNIT = .5

letters = { 'a': [ '.', '-' ],
            'b': [ '-', '.', '.', '.' ],
            'c': [ '-', '.', '-', '.' ],
            'd': [ '-', '.', '.' ],
            'e': [ '.' ],
            'f': [ '.', '.', '-', '.' ],
            'g': [ '-', '-', '.' ],
            'h': [ '.', '.', '.', '.' ],
            'i': [ '.', '.' ],
            'j': [ '.', '-', '-', '-' ],
            'k': [ '-', '.', '-' ],
            'l': [ '.', '-', '.', '.' ],
            'm': [ '-', '-' ],
            'n': [ '-', '.' ],
            'o': [ '-', '-', '-' ],
            'p': [ '.', '-', '-', '.' ],
            'q': [ '-', '-', '.', '-' ],
            'r': [ '.', '-', '.' ],
            's': [ '.', '.', '.' ],
            't': [ '-' ],
            'u': [ '.', '.', '-' ],
            'v': [ '.', '.', '.', '-' ],
            'w': [ '.', '-', '-' ],
            'x': [ '-', '.', '.', '-' ],
            'y': [ '-', '.', '-', '-' ],
            'z': [ '-', '-', '.', '.' ],
            '0': [ '-', '-', '-', '-', '-' ],
            '1': [ '.', '-', '-', '-', '-' ],
            '2': [ '.', '.', '-', '-', '-' ],
            '3': [ '.', '.', '.', '-', '-' ],
            '4': [ '.', '.', '.', '.', '-' ],
            '5': [ '.', '.', '.', '.', '.' ],
            '6': [ '-', '.', '.', '.', '.' ],
            '7': [ '-', '-', '.', '.', '.' ],
            '8': [ '-', '-', '-', '.', ',' ],
            '9': [ '-', '-', '-', '-', '.' ] }

def set_trigger():
    os.system('sudo sh -c "echo \"none\">/sys/class/leds/led0/trigger"')

def light():
    os.system('sudo sh -c \'echo "255">/sys/class/leds/led0/brightness\'')

def dark():
    os.system('sudo sh -c \'echo "0">/sys/class/leds/led0/brightness\'')

def show_letter(l):
    for c in letters[l]:
        if c == '.':
            light()
            sleep(UNIT)
        elif c == '-':
            light()
            sleep(3*UNIT)
        dark()
        sleep(UNIT)

set_trigger()
dark()
while True:
    key = readchar.readkey()
    print(key)
    show_letter(key)

