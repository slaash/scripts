#1/bin/bash

rsync -avz -e ssh --rsync-path="sudo rsync" <src> <dst>
