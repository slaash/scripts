#!/bin/bash

kubectl get pods -n kube-system -oname |grep coredns |xargs kubectl delete -n kube-system
