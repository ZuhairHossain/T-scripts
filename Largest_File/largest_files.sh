#!/usr/bin/env bash
# Find the largest 10 files in a given directory (files only)

set -euo pipefail

# Hardcoded directory path (change this if needed)
DIR="/home/zuhairhossain"

# Check if directory exists
if [[ ! -d "$DIR" ]]; then
    echo "Error: Directory '$DIR' does not exist."
    exit 1
fi

echo "Finding the 10 largest files in '$DIR'..."
echo "--------------------------------------------"

# Find all files, get their sizes in human-readable format, sort, and get top 10
find "$DIR" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10
