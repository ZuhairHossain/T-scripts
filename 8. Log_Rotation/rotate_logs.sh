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

# --- Remove all backups numbered greater than MAX_BACKUPS ---
for oldfile in "$LOGDIR/$BASENAME".*; do
    [[ -e "$oldfile" ]] || continue

    # Extract the number at the end
    number="${oldfile##*.}"
    if [[ "$number" =~ ^[0-9]+$ ]] && (( number > MAX_BACKUPS )); then
        echo "Removing extra old log: $oldfile"
        rm -f "$oldfile"
    fi
done

# --- Standard rotation: shift .4→.5, .3→.4, etc. ---
for ((i=MAX_BACKUPS-1; i>=1; i--)); do
    if [[ -f "${LOGFILE}.${i}" ]]; then
        mv "${LOGFILE}.${i}" "${LOGFILE}.$((i+1))"
    fi
done

# --- Move current log to .1 ---
mv "$LOGFILE" "${LOGFILE}.1"
touch "$LOGFILE"

echo "✅ Rotation complete for $LOGFILE"
ls -l "$LOGDIR"
