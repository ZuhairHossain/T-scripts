#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="${1:-log_test/test.log}"   # Default test log
KEYWORD="${2:-ALERT}"                # Default keyword
ALERT_COMMAND="${3:-echo}"           # Command to run when keyword found

# Check file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file '$LOG_FILE' does not exist."
    exit 1
fi

echo "Monitoring log file: $LOG_FILE"
echo "Alerting on keyword (case-insensitive): '$KEYWORD'"
echo "Press Ctrl+C to exit."

alert() {
    local line="$1"
    $ALERT_COMMAND "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: '$KEYWORD' found in $LOG_FILE: $line"
}

tail -F "$LOG_FILE" 2>/dev/null | grep -i --line-buffered "$KEYWORD" | while read -r line; do
    alert "$line"
done
