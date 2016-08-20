from evdev import InputDevice, categorize, ecodes

dev = InputDevice('/dev/input/event2')
print(dev)

SENSIV = 10

x = 0
y = 0
c = 0
for event in dev.read_loop():
    if event.type == ecodes.EV_REL:
        c = c+1
        if event.code == ecodes.ecodes['REL_X']:
            x = x+event.value
        elif event.code == ecodes.ecodes['REL_Y']:
            y = y+event.value
        if c % SENSIV == 0:
            if abs(x) > abs(y):
                if x > 0:
                    print('>'.format(x,y))
                elif x <= 0:
                    print('<'.format(x,y))
            elif abs(x) <= abs(y):
                if y > 0:
                    print(r'\/'.format(x,y))
                elif y <= 0:
                    print('^'.format(x,y))
            x = 0
            y = 0

