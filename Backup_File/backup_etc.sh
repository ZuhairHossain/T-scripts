#!/bin/bash

BACKUP_DIR="/backup"
mkdir -p "$BACKUP_DIR"

DATE=$(date +%Y%m%d)
BACKUP_FILE="$BACKUP_DIR/etc-$DATE.tar.gz"

tar -czf "$BACKUP_FILE" /etc

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Backup successful -> $BACKUP_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S'): Backup failed!"
    exit 1
fi

find "$BACKUP_DIR" -type f -name "etc-*.tar.gz" -mtime +7 -exec rm -f {} \;

echo "$(date '+%Y-%m-%d %H:%M:%S'): Cleanup completed. Old backups deleted if any."
