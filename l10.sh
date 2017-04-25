#!/bin/bash
# Show all files EXCEPT the newest 10

echo "--- ls ---"
for i in $(ls -t file-*|tail -n +11);do
    echo "${i}"
done

echo "--- find ---"
for i in $(find . -mindepth 1 -maxdepth 1 -type f|sort -r|tail -n +11); do
    echo "${i}"
done
