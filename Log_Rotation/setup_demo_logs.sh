#!/usr/bin/env bash
set -euo pipefail

LOG_DIR="./log_files"
LOG_FILE="${LOG_DIR}/demo.log"

mkdir -p "$LOG_DIR"
rm -f "${LOG_FILE}" "${LOG_FILE}".{1..10} 2>/dev/null || true

# Create demo logs with artificial timestamps
for i in {1..7}; do
    echo "This is sample content for demo.log.$i" > "${LOG_FILE}.${i}"
    # Set timestamp: older files have earlier dates
    # Format: [[CC]YY]MMDDhhmm[.SS]
    touch -t 2025090$((i+1))0800 "${LOG_FILE}.${i}"
done

# Current log file with newest timestamp
echo "This is the current log file" > "$LOG_FILE"
touch -t 202509081200 "$LOG_FILE"

echo "✅ Demo logs created with artificial timestamps"
ls -lt "$LOG_DIR"
