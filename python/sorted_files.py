import os

filez = {}
fullpath = '/home/radu/tmp/tmp'
for root, dirs, files in os.walk(fullpath):
    for fil in sorted(files, reverse=True):
        size = os.stat(os.path.join(root, fil)).st_size
        filez[fil] = [size]

print filez.keys()

