from evdev import InputDevice, categorize, ecodes

dev = InputDevice('/dev/input/event2')
print(dev)

SENSIV = 10

x = 0
c_x = 0
y = 0
c_y = 0
c = 0
for event in dev.read_loop():
    if event.type == ecodes.EV_REL:
#       print(event.code)
        c = c+1
        if event.code == ecodes.ecodes['REL_X']:
            c_x = c_x+1
            x = x+event.value
        elif event.code == ecodes.ecodes['REL_Y']:
            c_y = c_y+1
            y = y+event.value
        if c % SENSIV == 0:
            if c_x > c_y:
                if x > 0:
                    print('>')
                elif x < 0:
                    print('<')
            elif c_x < c_y:
                if y > 0:
                    print(r'\/')
                elif y < 0:
                    print('^')
            x = 0
            c_x = 0
            y = 0
            c_y = 0

