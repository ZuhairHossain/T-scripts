#!/usr/bin/env bash
# Rename all files in a directory to include today's date

set -euo pipefail

# === Configuration ===
# You can hardcode the directory path or accept as an argument
DIR="${1:-test_files}"

# Get today's date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)

# Check if directory exists
if [[ ! -d "$DIR" ]]; then
    echo "Error: Directory '$DIR' does not exist."
    exit 1
fi

echo "Renaming files in '$DIR' by appending date: $TODAY"
echo "-----------------------------------------------------"

cd "$DIR"

# Loop through files
for FILE in *; do
    # Skip directories
    if [[ -f "$FILE" ]]; then
        BASENAME="${FILE%.*}"        # File name without extension
        EXT="${FILE##*.}"            # Extension
        # Handle files without extension
        if [[ "$BASENAME" == "$EXT" ]]; then
            NEWNAME="${BASENAME}_${TODAY}"
        else
            NEWNAME="${BASENAME}_${TODAY}.${EXT}"
        fi
        mv -v "$FILE" "$NEWNAME"
    fi
done

echo "✅ Renaming complete."
