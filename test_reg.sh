#!/bin/bash

for i in {1..20}; do
    echo "RUN #${i}"
    docker rmi registry.uberresearch.com/my_app:test3 registry.uberresearch.com/my_app:test2 registry.uberresearch.com/my_app:test1
    (docker pull registry.uberresearch.com/my_app:test3) &
    (docker pull registry.uberresearch.com/my_app:test2) &
    (docker pull registry.uberresearch.com/my_app:test1) &
    echo "Waiting docker pull to finish..."
    wait
done

