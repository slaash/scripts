#!/usr/bin/python

import readchar
import os
from time import sleep
from evdev import InputDevice, categorize, ecodes

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

ecodez = { 'KEY_A': 'a', 'KEY_B': 'b', 'KEY_C': 'c', 'KEY_D': 'd', 'KEY_E': 'e', 'KEY_F': 'f',
           'KEY_G': 'g', 'KEY_H': 'h', 'KEY_I': 'i', 'KEY_J': 'j', 'KEY_K': 'k', 'KEY_L': 'l',
           'KEY_M': 'm', 'KEY_N': 'n', 'KEY_O': 'o', 'KEY_P': 'p', 'KEY_Q': 'q', 'KEY_R': 'r',
           'KEY_S': 's', 'KEY_T': 't', 'KEY_U': 'u', 'KEY_V': 'v', 'KEY_W': 'w', 'KEY_X': 'x',
           'KEY_Y': 'y', 'KEY_Z': 'z',
           'KEY_0': '0', 'KEY_1': '1', 'KEY_2': '2', 'KEY_3':'3', 'KEY_4': '4', 'KEY_5': '5',
           'KEY_6': '6', 'KEY_7': '7', 'KEY_8': '8', 'KEY_9': '9' }

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

dev = InputDevice('/dev/input/event0')
print(dev)

set_trigger()
dark()
#while True:
#    key = readchar.readkey()
#    print(key)
#    show_letter(key)

for event in dev.read_loop():
    if event.type == ecodes.EV_KEY:
        c = categorize(event)
        if c.keystate == c.key_down:
            for k in ecodez.keys():
                if event.code ==  ecodes.ecodes[k]:
                    show_letter(ecodez[k])

