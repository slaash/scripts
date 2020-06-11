#!/bin/bash

find . -name "*.yml"|xargs -i -t rename 's/.yml/.yaml/g' {}
