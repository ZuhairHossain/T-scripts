#!/bin/bash
# process_monitor.sh
# A script to monitor a process by name and restart if it's not running.
# Usage: ./process_monitor.sh <process_name> <service_name>

PROCESS_NAME=$1
SERVICE_NAME=$2
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

if [ -z "$PROCESS_NAME" ] || [ -z "$SERVICE_NAME" ]; then
    echo "Usage: $0 <process_name> <service_name>"
    exit 1
fi

if ! pgrep -x "$PROCESS_NAME" > /dev/null; then
    echo "$TIMESTAMP - $PROCESS_NAME not running! Restarting $SERVICE_NAME..." >> process_monitor.log
    systemctl restart "$SERVICE_NAME"
    if [ $? -eq 0 ]; then
        echo "$TIMESTAMP - Successfully restarted $SERVICE_NAME" >> process_monitor.log
    else
        echo "$TIMESTAMP - Failed to restart $SERVICE_NAME" >> process_monitor.log
    fi
else
    echo "$TIMESTAMP - $PROCESS_NAME is running." >> process_monitor.log
fi
