#!/bin/bash

#head -1000000 <(strings <(cat /dev/urandom))>f1.txt
#head -1000000 <(strings <(cat /dev/urandom))>f2.txt
#sort <(sort f1.txt) <(sort f2.txt) > f3.txt

strings < <(cat /dev/urandom) > >(tee > >(grep "aaa") >(grep "bbb"))

