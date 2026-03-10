#!/bin/bash

until ping -c 1 webapps-lb
do
    echo "waiting for webapps load balancer to appear (1 sec)"
    sleep 1
done

echo "done with it"
