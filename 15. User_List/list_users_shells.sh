#!/bin/bash

set -euo pipefail

PASSWD_FILE="/etc/passwd"

if [[ ! -r "$PASSWD_FILE" ]]; then
    echo "Error: Cannot read $PASSWD_FILE. Check permissions."
    exit 1
fi

echo "============================================"
echo "Users with /bin/bash shell"
echo "--------------------------------------------"

# Use awk to filter only bash users
awk -F: '$7 == "/bin/bash" {printf "%-20s | %s\n", $1, $7}' "$PASSWD_FILE"

echo "============================================"
BASH_USER_COUNT=$(awk -F: '$7 == "/bin/bash"' "$PASSWD_FILE" | wc -l)
echo "Total Bash Users: $BASH_USER_COUNT"
