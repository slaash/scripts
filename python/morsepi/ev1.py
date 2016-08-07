from evdev import InputDevice, categorize, ecodes
dev = InputDevice('/dev/input/event0')
print(dev)

for event in dev.read_loop():
   if event.type == ecodes.EV_KEY:
       print(event.code)
       if event.code ==  ecodes.ecodes['KEY_A']:
           print('A!')

