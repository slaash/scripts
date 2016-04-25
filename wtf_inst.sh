#!/bin/bash

aws ec2 describe-instances --region us-east-1 --filter "Name=instance-id,Values=${1}"|grep -E "Key|Value|InstanceType|PrivateIpAddress"
aws ec2 describe-instances --region us-east-1 --filter "Name=instance-id,Values=${1}" --query 'Reservations[].Instances[].[PrivateIpAddress][0][0]'|tr -d '"'|xargs route53host.sh

