#!/usr/bin/python

from readchar import readkey
from subprocess import call
from time import sleep, strftime, localtime
from evdev import InputDevice, categorize, ecodes
from sys import stdout
from os import geteuid, seteuid

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
    uid = geteuid()
    seteuid(0)
    with open('/sys/class/leds/led0/trigger', 'w') as f:
        f.write('none')
    seteuid(uid)

def light():
    uid = geteuid()
    seteuid(0)
    with open('/sys/class/leds/led0/brightness', 'w') as f:
        f.write('255')
    seteuid(uid)

def dark():
    uid = geteuid()
    seteuid(0)
    with open('/sys/class/leds/led0/brightness', 'w') as f:
        f.write('0')
    seteuid(uid)

def blink(t):
    light()
    sleep(t)
    dark()

def power_off():
    call(['sudo', 'poweroff'])

#if the duration of a dot is taken to be one unit
#then that of a dash is three units.
#The space between the components of one character is one unit,
#between characters is three units and between words seven units.
#To indicate that a mistake has been made and for the receiver to delete the last word, send ........ (eight dots).

def show_letter(l):
    l = l.lower()
    if l in letters:
        if DEBUG:
            stdout.write("{} ( {} ) ... ".format(l, " ".join(letters[l])))
            stdout.flush()
        c = 0
        while c < len(letters[l]):
            if letters[l][c] == '.':
                blink(UNIT)
            elif letters[l][c] == '-':
                blink(3*UNIT)
            if c < len(letters[l])-1:
                dark()
                sleep(UNIT)
            c = c+1
        if DEBUG:
            print("done.")
        return 0
    else:
        return 1

def show_word(w):
    if DEBUG:
        print(w)
    c = 0
    while c < len(w):
        show_letter(w[c])
        if c < len(w)-1:
            sleep(3*UNIT)
        c = c+1
    sleep(7*UNIT)

def process_secv(s):
    if secv == 'bye':
        power_off()
    elif secv == 'time':
        for w in strftime("%I %M %p", localtime()).split(" "):
            show_word(w)
    else:
        show_word(s)

if __name__ == "__main__":
    set_trigger()
    secv = ""
    print("Started")
    if MODE == "local":
        while True:
            key = readkey()
            if ord(key) == 13:
                process_secv(secv)
                secv = ""
            else:
                if show_letter(key) == 0:
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
                        process_secv(secv)
                        secv = ""
                    else:
                        for k in ecodez.keys():
                            if event.code == ecodes.ecodes[k]:
                                letter = ecodez[k]
                                show_letter(letter)
                                secv = secv + letter

