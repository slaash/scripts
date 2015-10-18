#!/bin/bash

curl -s http://www.eu.apache.org/dist/lucene/solr/|grep -oE ">[0-9]+\.[0-9]+\.[0-9]+/<"|tr -d "></"|sort
