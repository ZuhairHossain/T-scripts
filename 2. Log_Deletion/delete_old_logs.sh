#!/bin/bash

# Directory where log files are stored
LOG_DIR="../demo_logs"

DAYS=7

CLEANUP_LOG="Log_Deletion/cleanup_logs.log"

OLD_LOGS=$(find "$LOG_DIR" -type f -name "*.log" -mtime +"$DAYS")

if [ -z "$OLD_LOGS" ]; then
    echo "$(date): No log files older than $DAYS days found in $LOG_DIR." | tee -a "$CLEANUP_LOG"
else
    echo "$(date): Deleting the following log files older than $DAYS days from $LOG_DIR:" | tee -a "$CLEANUP_LOG"
    echo "$OLD_LOGS" | tee -a "$CLEANUP_LOG"
    
    while IFS= read -r file; do
        rm -f "$file"
    done <<< "$OLD_LOGS"

    echo "$(date): Deletion completed." | tee -a "$CLEANUP_LOG"
fi
