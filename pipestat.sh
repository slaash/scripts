#!/bin/bash

ps aux|grep [a]aaaa|grep 1

for i in "${PIPESTATUS[@]}"; do
	echo "${i}"
done

