from evdev import InputDevice, categorize, ecodes
from math import sqrt, pow
from random import uniform
from morsepi import set_trigger, blink

dev = InputDevice('/dev/input/event2')
print(dev)

SENSIV = 10

my_x = int(uniform(-1000, 1000))
my_y = int(uniform(-1000, 1000))
print(my_x, my_y)
set_trigger()
x = 0
y = 0
for event in dev.read_loop():
    if event.type == ecodes.EV_REL:
        if event.code == ecodes.ecodes['REL_X']:
            x = x + event.value
        elif event.code == ecodes.ecodes['REL_Y']:
            y = y - event.value
        ab = abs(x) - abs(my_x)
        ac = abs(y) - abs(my_y)
        bc = int(sqrt(pow(ab, 2) + pow(ac, 2)))
        print("x: {} y: {}, dist: {}".format(x, y, bc))

