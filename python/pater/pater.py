from multiprocessing import Process

def _procWatcher():
    while True:
        

if __name__ == 'main':
    watch = Process(target=_procWatcher)
    watch.start()
