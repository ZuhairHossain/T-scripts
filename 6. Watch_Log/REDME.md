# Watch Log Alert Script README

This document explains the usage and functionality of the `watch_log_alert_case_insensitive.sh` script, which monitors a log file in real-time and alerts if a specific keyword appears (case-insensitive).

---

## 1. Overview

`watch_log_alert_case_insensitive.sh` is a Bash script designed to:

* Monitor a log file continuously in real-time.
* Detect a specified keyword regardless of its capitalization (e.g., ALERT, Alert, aLeRt).
* Trigger an alert using a command (default: echo to stdout, but can be configured for SMPP or SMSC notifications).
* Handle log rotation gracefully without needing cronjobs.

---

## 2. Script: `watch_log_alert_case_insensitive.sh`

```bash
#!/usr/bin/env bash
# Watch log file in real-time and alert for keyword (case-insensitive)
set -euo pipefail

LOG_FILE="${1:-./log_test/test.log}"   # Default test log in current directory
KEYWORD="${2:-ALERT}"                  # Default keyword
ALERT_COMMAND="${3:-echo}"             # Command to run when keyword found, can be customized for SMPP/SMSC

# Check file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file '$LOG_FILE' does not exist."
    exit 1
fi

echo "Monitoring log file: $LOG_FILE"
echo "Alerting on keyword (case-insensitive): '$KEYWORD'"
echo "Press Ctrl+C to exit."

# Alert function
alert() {
    local line="$1"
    $ALERT_COMMAND "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: '$KEYWORD' found in $LOG_FILE: $line"
}

# Tail with case-insensitive, line-buffered grep
tail -F "$LOG_FILE" 2>/dev/null | grep -i --line-buffered "$KEYWORD" | while read -r line; do
    alert "$line"
done
```

---

## 3. Usage

1. **Make the script executable**

```bash
chmod +x watch_log_alert_case_insensitive.sh
```

   **Run the script**

```bash
# Monitor the default log file in ./log_test/ with default keyword 'ALERT'
./watch_log_alert_case_insensitive.sh

# Custom keyword and alert command (e.g., send email or SMPP/SMSC notification)
./watch_log_alert_case_insensitive.sh ./log_test/test.log ERROR "mail -s 'Log Alert' user@example.com"
```

---

## 4. Testing

1. Create a test log directory and file in the current directory:

```bash
mkdir -p ./log_test
TEST_LOG=./log_test/test.log
touch "$TEST_LOG"
```

2. Run the script:

```bash
./watch_log_alert_case_insensitive.sh
```

3. Append lines to the log in another terminal:

```bash
echo "This is normal" >> ./log_test/test.log
echo "ALERT: Something went wrong!" >> ./log_test/test.log
echo "Alert: Minor issue" >> ./log_test/test.log
echo "aLeRt: Check immediately" >> ./log_test/test.log
```

**Expected Output:**

```
[2025-10-06 10:25:12] ALERT: 'ALERT' found in ./log_test/test.log: ALERT: Something went wrong!
[2025-10-06 10:25:15] ALERT: 'ALERT' found in ./log_test/test.log: Alert: Minor issue
[2025-10-06 10:25:18] ALERT: 'ALERT' found in ./log_test/test.log: aLeRt: Check immediately
```

---

## 5. Notes

* The script runs **continuously**, no cron required.
* Handles log rotation using `tail -F`.
* Detects the keyword **case-insensitively** using `grep -i`.
* Alerts can be customized to any command: `echo`, `mail`, or even SMPP/SMSC notifications.
* Default test log is stored in `./log_test/` relative to the script location.
