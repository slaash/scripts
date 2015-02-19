#!/bin/bash

for i in {1..10}; do
	./cl_req.py &
done

for j in $(jobs -p); do
	echo "Waiting for pid ${j}"
	wait ${j}
done

