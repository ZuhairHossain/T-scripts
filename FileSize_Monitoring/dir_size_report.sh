#!/bin/bash

DIR_LIST=(
    "/home/zuhairhossain"
    "/var/log"
    "/tmp"
    "/opt"
)

echo "Directory Size Report - $(date)"
echo "---------------------------------"

for DIR in "${DIR_LIST[@]}"; do
    if [ -d "$DIR" ]; then
        SIZE=$(du -sh "$DIR" 2>/dev/null | awk '{print $1}')
        echo "Directory: $DIR | Size: $SIZE"
    else
        echo "Directory: $DIR does not exist or is not a directory"
    fi
done

echo "---------------------------------"
echo "Report completed."
