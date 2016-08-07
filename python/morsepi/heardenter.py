#!/usr/bin/bash

import sys
import select

def heardEnter():
    i,o,e = select.select([sys.stdin],[],[],0.0001)
    for s in i:
        if s == sys.stdin:
            input = sys.stdin.readline()
            return True
    return False

while True:
    if heardEnter():
        print("Enter!")

