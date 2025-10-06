# Rename Files with Today's Date

This Bash script renames all files in a given directory to include today's date in their filenames.

## 🧩 Script: `rename_with_date.sh`

```bash
#!/usr/bin/env bash
# Rename all files in a directory to include today's date

set -euo pipefail

# === Configuration ===
# You can hardcode the directory path or accept as an argument
DIR="${1:-/test_files}"

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
```

---

## 📘 Usage

1. **Make the script executable**
   ```bash
   chmod +x rename_with_date.sh
   ```

2. **Run the script**
   ```bash
   ./rename_with_date.sh /path/to/your/files
   ```

   If no directory is given, it defaults to `/test_files`.

---

## 🧪 Example

**Before:**
```
report.txt
data.csv
photo.jpg
```

**After running on 2025-10-05:**
```
report_2025-10-05.txt
data_2025-10-05.csv
photo_2025-10-05.jpg
```

---

## 💡 Notes
- Only files are renamed; directories are skipped.
- The script preserves file extensions.
- Works on any Unix-like system (Linux, macOS, WSL).

