#1/bin/bash

rsync -avz --delete -e ssh --rsync-path="sudo rsync" <src> <dst>
