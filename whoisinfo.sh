#!/bin/bash

ADDR=${1}

whois ${ADDR}|grep -E "descr:|address:|country:"
