#!/usr/bin/python

import readchar
import subprocess
from time import sleep
from evdev import InputDevice, categorize, ecodes
import sys

UNIT = .5
MODE = "local"
DEBUG = True

letters = {'a': ['.', '-'],
            'b': ['-', '.', '.', '.'],
            'c': ['-', '.', '-', '.'],
            'd': ['-', '.', '.'],
            'e': ['.'],
            'f': ['.', '.', '-', '.'],
            'g': ['-', '-', '.'],
            'h': ['.', '.', '.', '.'],
            'i': ['.', '.'],
            'j': ['.', '-', '-', '-'],
            'k': ['-', '.', '-'],
            'l': ['.', '-', '.', '.'],
            'm': ['-', '-'],
            'n': ['-', '.'],
            'o': ['-', '-', '-'],
            'p': ['.', '-', '-', '.'],
            'q': ['-', '-', '.', '-'],
            'r': ['.', '-', '.'],
            's': ['.', '.', '.'],
            't': ['-'],
            'u': ['.', '.', '-'],
            'v': ['.', '.', '.', '-'],
            'w': ['.', '-', '-'],
            'x': ['-', '.', '.', '-'],
            'y': ['-', '.', '-', '-'],
            'z': ['-', '-', '.', '.'],
            '0': ['-', '-', '-', '-', '-'],
            '1': ['.', '-', '-', '-', '-'],
            '2': ['.', '.', '-', '-', '-'],
            '3': ['.', '.', '.', '-', '-'],
            '4': ['.', '.', '.', '.', '-'],
            '5': ['.', '.', '.', '.', '.'],
            '6': ['-', '.', '.', '.', '.'],
            '7': ['-', '-', '.', '.', '.'],
            '8': ['-', '-', '-', '.', ','],
            '9': ['-', '-', '-', '-', '.'],
            '-': ['-', '.', '.', '.', '.', '-'],
            '+': ['.', '-', '.', '-', '.']}

ecodez = {'KEY_A': 'a', 'KEY_B': 'b', 'KEY_C': 'c', 'KEY_D': 'd', 'KEY_E': 'e', 'KEY_F': 'f',
           'KEY_G': 'g', 'KEY_H': 'h', 'KEY_I': 'i', 'KEY_J': 'j', 'KEY_K': 'k', 'KEY_L': 'l',
           'KEY_M': 'm', 'KEY_N': 'n', 'KEY_O': 'o', 'KEY_P': 'p', 'KEY_Q': 'q', 'KEY_R': 'r',
           'KEY_S': 's', 'KEY_T': 't', 'KEY_U': 'u', 'KEY_V': 'v', 'KEY_W': 'w', 'KEY_X': 'x',
           'KEY_Y': 'y', 'KEY_Z': 'z',
           'KEY_0': '0', 'KEY_1': '1', 'KEY_2': '2', 'KEY_3':'3', 'KEY_4': '4', 'KEY_5': '5',
           'KEY_6': '6', 'KEY_7': '7', 'KEY_8': '8', 'KEY_9': '9'}

def set_trigger():
    subprocess.call(['sudo', 'sh', '-c', "echo \"none\">\"/sys/class/leds/led0/trigger\""])

def light():
    subprocess.call(['sudo', 'sh', '-c', "echo \"255\">\"/sys/class/leds/led0/brightness\""])

def dark():
    subprocess.call(['sudo', 'sh', '-c', "echo \"0\">\"/sys/class/leds/led0/brightness\""])

def power_off():
    subprocess.call(['sudo', 'poweroff'])

def show_letter(l):
    if DEBUG:
        sys.stdout.write("{} ( {} ) ... ".format(l, " ".join(letters[l])))
        sys.stdout.flush()
    for c in letters[l]:
        if c == '.':
            light()
            sleep(UNIT)
        elif c == '-':
            light()
            sleep(3*UNIT)
        dark()
        sleep(UNIT)
    if DEBUG:
        print("done.")

def show_word(w):
    if DEBUG:
        print(w)
    for l in w:
        show_letter(l)
        sleep(3*UNIT)

set_trigger()
dark()
secv = ""
print("Started")
if MODE == "local":
    while True:
        key = readchar.readkey()
        if ord(key) == 13:
            show_word(secv)
            secv = ""
        else:
            show_letter(key)
            secv = secv + key
else:
    dev = InputDevice('/dev/input/event0')
    if DEBUG:
        print(dev)
    for event in dev.read_loop():
        if event.type == ecodes.EV_KEY:
            c = categorize(event)
            if c.keystate == c.key_down:
                if event.code == ecodes.ecodes['KEY_ENTER']:
                    if secv == 'bye':
                        power_off()
                    else:
                        show_word(secv)
                    secv = ""
                else:
                    for k in ecodez.keys():
                        if event.code == ecodes.ecodes[k]:
                            letter = ecodez[k]
                            show_letter(letter)
                            secv = secv + letter

