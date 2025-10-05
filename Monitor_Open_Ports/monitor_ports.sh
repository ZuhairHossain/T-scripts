#!/usr/bin/env bash
# Monitor TCP ports and log changes

set -euo pipefail

# Configuration
SNAPSHOT_FILE="./current_ports.txt"
PREV_SNAPSHOT_FILE="./prev_ports.txt"
LOG_FILE="./port_changes.log"

# Take a snapshot of current open TCP ports (list only ports and process info)
ss -tlnp | awk 'NR>1 {print $4, $6}' | sort > "$SNAPSHOT_FILE"

# If previous snapshot doesn't exist, create it
if [[ ! -f "$PREV_SNAPSHOT_FILE" ]]; then
    cp "$SNAPSHOT_FILE" "$PREV_SNAPSHOT_FILE"
    echo "$(date '+%Y-%m-%d %H:%M:%S') Initial snapshot created." >> "$LOG_FILE"
    exit 0
fi

# Compare snapshots and log differences
diff_output=$(diff "$PREV_SNAPSHOT_FILE" "$SNAPSHOT_FILE")

if [[ -n "$diff_output" ]]; then
    echo "==================== $(date '+%Y-%m-%d %H:%M:%S') ====================" >> "$LOG_FILE"
    echo "$diff_output" >> "$LOG_FILE"
    echo "Changes detected and logged to $LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') No changes detected."
fi

# Update previous snapshot
cp "$SNAPSHOT_FILE" "$PREV_SNAPSHOT_FILE"
