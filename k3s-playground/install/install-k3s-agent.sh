#!/bin/bash
# installs only the k3s agent
# get the token from the server: sudo cat /var/lib/rancher/k3s/server/node-token

curl -sfL https://get.k3s.io | sudo K3S_URL=https://...:6443 K3S_TOKEN='...' sh -
