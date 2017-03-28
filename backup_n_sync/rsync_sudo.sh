#!/bin/bash

rsync -avz --delete -e ssh --rsync-path="sudo rsync" <src> <dst>
sudo -E rsync -avz -e ssh --rsync-path="sudo rsync" /var/solr/data/* <user>@<dst>:/var/solr/data
