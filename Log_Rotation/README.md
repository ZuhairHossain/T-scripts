# Log Rotation Script

This document explains how the `rotate_logs.sh` script works, how to set up a demo environment, and how to use the script for log rotation in a Linux environment.

---

## 1. Overview

`rotate_logs.sh` is a production-ready Bash script that rotates log files, keeping the last 5 versions and automatically deleting older ones. It is safe, simple, and works with any log file specified by the user.

Key features:

- Keeps the last **5 log backups** (.1 to .5).
- Deletes any older backups (.6, .7, etc.).
- Creates an empty current log file after rotation.
- Can be integrated into cron jobs or automated scripts.

---

## 2. Script Details

### Script: rotate_logs.sh

```bash
#!/usr/bin/env bash
set -euo pipefail

MAX_BACKUPS=5

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 /path/to/logfile.log"
    exit 1
fi

LOGFILE="$1"
LOGDIR="$(dirname "$LOGFILE")"
BASENAME="$(basename "$LOGFILE")"

if [[ ! -f "$LOGFILE" ]]; then
    echo "Error: Log file '$LOGFILE' not found."
    exit 1
fi

# Remove all backups numbered greater than MAX_BACKUPS
for oldfile in "$LOGDIR/$BASENAME".*; do
    [[ -e "$oldfile" ]] || continue

    number="${oldfile##*.}"
    if [[ "$number" =~ ^[0-9]+$ ]] && (( number > MAX_BACKUPS )); then
        echo "Removing extra old log: $oldfile"
        rm -f "$oldfile"
    fi
Done

# Shift existing backups
for ((i=MAX_BACKUPS-1; i>=1; i--)); do
    if [[ -f "${LOGFILE}.${i}" ]]; then
        mv "${LOGFILE}.${i}" "${LOGFILE}.$((i+1))"
    fi
Done

# Rotate current log
mv "$LOGFILE" "${LOGFILE}.1"
touch "$LOGFILE"

echo "✅ Rotation complete for $LOGFILE"
ls -l "$LOGDIR"
```

### How it works

1. **Delete old backups beyond `.5`**: ensures only the last 5 backups remain.
2. **Shift backups**: `.4 → .5`, `.3 → .4`, etc.
3. **Rotate current log**: moves the current log to `.1`.
4. **Create empty current log**: ensures the log file is ready for new entries.

---

## 3. Setting Up a Demo Environment

To test the script locally, you can create a demo log directory with some log files.

### Setup Script: setup_demo_logs.sh

```bash
#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="./log_files"
LOG_FILE="${LOG_DIR}/demo.log"

mkdir -p "$LOG_DIR"
rm -f "${LOG_FILE}" "${LOG_FILE}".{1..10} 2>/dev/null || true

# Create demo logs with timestamps
for i in {1..7}; do
    echo "This is sample content for demo.log.$i" > "${LOG_FILE}.${i}"
    touch -t 2025090$((i+1))0800 "${LOG_FILE}.${i}"
Done

# Current log file
echo "This is the current log file" > "$LOG_FILE"
touch -t 202509081200 "$LOG_FILE"

echo "✅ Demo logs created in $LOG_DIR"
ls -lt "$LOG_DIR"
```

Run the setup script:

```bash
chmod +x setup_demo_logs.sh
./setup_demo_logs.sh
```

---

## 4. Using the Rotation Script

1. Make the rotation script executable:

```bash
chmod +x rotate_logs.sh
```

2. Rotate your log file:

```bash
./rotate_logs.sh ./log_files/demo.log
```

3. Check results:

- `demo.log` → new empty file
- `demo.log.1` → previous current log
- `demo.log.2`–`demo.log.5` → older backups
- Any `.6` or higher deleted automatically

---

## 5. Automating Rotation

Add the script to `cron` for daily rotation, e.g.: 

```bash
0 0 * * * /path/to/rotate_logs.sh /path/to/logfile.log
```

---

## 6. Notes

- The script only works with numeric suffixes (`.1`, `.2`, …).
- Old logs beyond the configured `MAX_BACKUPS` are automatically removed.
- Ensure proper permissions to write and delete files in the log directory.

---

This setup allows safe and automated log rotation in Linux environments