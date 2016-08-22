import morsepi

for led in ["led0", "led1"]:
    morsepi.LED=led
    morsepi.set_trigger()

