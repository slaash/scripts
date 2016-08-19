import evdev
import json

devices = [evdev.InputDevice(fn) for fn in evdev.list_devices()]
for device in devices:
    print("{} {} {}\n{}".format(device.fn, device.name, device.phys, device.capabilities(verbose=True)))
