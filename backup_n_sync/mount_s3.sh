#!/bin/bash

/bin/fusermount -u /mnt/slaashstore

export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...

yas3fs --recheck-s3 --log ${HOME}/yas3fs.log s3://slaashstore/ /mnt/slaashstore
