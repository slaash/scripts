#!/bin/bash

aws route53 list-resource-record-sets --hosted-zone-id "/hostedzone/Z29CUWZ5ZQGDVX" --query "ResourceRecordSets[?ResourceRecords[0].Value==\`${1}\`] | [0].Name"
