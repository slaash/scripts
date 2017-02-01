from multiprocessing import Process
import psutil
import time

def _procWatcher():
    while True:
        for pid in psutil.pids():
            p = psutil.Process(pid)
            try:
                print(p.name(), p.exe())
                if p.name == 'top':
                    print 
            except Exception:
                pass
        time.sleep(5)

if __name__ == '__main__':
    watch = Process(target=_procWatcher)
    watch.start()
