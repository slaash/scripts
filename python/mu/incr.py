from microbit import *

def show(n):
    display.scroll(str(n))

display.clear()

n=0
show(n)
while True:
    if button_a.is_pressed():
        n=n+1
        show(n)
    elif button_b.is_pressed():
        n=0
        show(n)
