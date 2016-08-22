from evdev import InputDevice, categorize, ecodes
from math import sqrt, pow
from random import uniform
from morsepi import UNIT, set_trigger, blink
from multiprocessing import Process, Pipe

dev = InputDevice('/dev/input/event2')
print(dev)

DELAY = .1

def led_action(t):
    print("led_action: {}".format(t))
    while True:
        blink(t)

my_x = int(uniform(-1000, 1000))
my_y = int(uniform(-1000, 1000))
print(my_x, my_y)
set_trigger()
x = 0
y = 0
p_conn, c_conn = Pipe()
led_proc = Process(target=led_action, args=(DELAY,))
led_proc.start()
for event in dev.read_loop():
    if event.type == ecodes.EV_REL:
        if event.code == ecodes.ecodes['REL_X']:
            x = x + event.value
        elif event.code == ecodes.ecodes['REL_Y']:
            y = y - event.value
        ab = abs(x - my_x)
        ac = abs(y - my_y)
        bc = int(sqrt(pow(ab, 2) + pow(ac, 2)))
        print("x: {}({}) y: {}({}), dist: {}".format(x, my_x, y, my_y, bc))
        if bc == 0:
            t = 0
        elif 0 < bc <= 10:
            t = DELAY
        elif 10 < bc <= 50:
            t = DELAY * 2
        elif 50 < bc <= 100:
            t = DELAY * 3
        elif 100 < bc <= 500:
            t = DELAY * 4
        elif 500 < bc <= 1000:
            t = DELAY * 5
        elif bc > 1000:
            t = DELAY * 6
        led_proc.terminate()
        led_proc = Process(target=led_action, args=(t,))
        led_proc.start()


