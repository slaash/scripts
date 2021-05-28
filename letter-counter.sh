#!/bin/bash

ALPHA=( {A..Z} )
alpha_increment () {
    echo ${ALPHA[${i:-0}]};
    ((i++))
}
alpha_increment 2
