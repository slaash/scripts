from multiprocessing import Process
from time import sleep
from os import getpid

def _worker():
    p = getpid()
    c = 0
    while c <= 3:
        print('Worker {}'.format(p))
        sleep(1)
        c = c+1

w = Process(target=_worker)
w.start()

while True:
    p = getpid()
    if w.is_alive():
        print("Master {}: worker alive {} !".format(p, w.is_alive()))
    else:
        print("Master {}: worker alive {}, restarting!".format(p, w.is_alive()))
        w.join()
        w = Process(target=_worker)
        w.start()
    sleep(1)
