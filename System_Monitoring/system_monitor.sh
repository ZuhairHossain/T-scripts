#!/bin/bash

LOG_DIR="."
mkdir -p "$LOG_DIR"

RETENTION_DAYS=15

HOSTNAME=$(hostname)
IP_ADDR=$(hostname -I | awk '{print $1}')

while true; do
    TODAY=$(date +%F)
    LOG_FILE="$LOG_DIR/${HOSTNAME}_${IP_ADDR}_$TODAY.log"
    CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {printf "User: %s%%, System: %s%%, Idle: %s%%", $2, $4, $8}')
    
    MEM_INFO=$(free -m | awk 'NR==2{printf "Used: %sMB/%sMB (%.2f%%)", $3, $2, $3*100/$2 }')

    echo "$(date '+%Y-%m-%d %H:%M:%S') | CPU: $CPU_USAGE | RAM: $MEM_INFO" >> "$LOG_FILE"

    find "$LOG_DIR" -type f -name "${HOSTNAME}_*.log" -mtime +"$RETENTION_DAYS" -exec rm -f {} \;

    sleep 10
done
