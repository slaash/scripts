#!/bin/bash

sudo apparmor_status
sudo invoke-rc.d apparmor kill
sudo invoke-rc.d apparmor stop
sudo apparmor_status
