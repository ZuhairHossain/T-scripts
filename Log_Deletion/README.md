# Delete Old Logs Script

This Bash script finds and deletes log files older than a specified number of days. It also logs the deleted files and prints messages if no old logs are found.

## Features
- Deletes `.log` files older than a specified number of days.
- Handles filenames with spaces or special characters.
- Logs deleted files and actions.
- Prints messages if no old log files are found.

## Script
```bash
#!/bin/bash

# Directory where log files are stored
LOG_DIR="/path/to/logs"

# Number of days after which logs will be deleted
DAYS=7

# Log file for cleanup actions
CLEANUP_LOG="$LOG_DIR/cleanup_logs.log"

# Find log files older than $DAYS
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
```

## Test Process (Demo)

1. **Create a demo folder for logs:**
```bash
mkdir -p ~/demo_logs
```

2. **Create demo log files:**
```bash
touch ~/demo_logs/test1.log
touch ~/demo_logs/test2.log
touch ~/demo_logs/test3.log
```

3. **Set some files to be older than 7 days:**
```bash
touch -d "10 days ago" ~/demo_logs/test2.log
touch -d "15 days ago" ~/demo_logs/test3.log
```

4. **Update script to point to demo folder:**
```bash
LOG_DIR="$HOME/demo_logs"
```

5. **Run the script:**
```bash
bash delete_old_logs.sh
```

6. **Check the log of deleted files:**
```bash
cat ~/demo_logs/cleanup_logs.log
```

7. **Clean up demo folder after testing:**
```bash
rm -rf ~/demo_logs
```

## Cronjob (Optional)
To run the script automatically every night at 2 AM, add a cronjob:
```bash
0 2 * * * /path/to/delete_old_logs.sh
```

## Notes
- Ensure the script has execute permissions:
```bash
chmod +x delete_old_logs.sh
```
- For real `/var/log` cleanup, run the script with `sudo` to avoid permission issues.
- Always test with demo logs before running on production logs.