#!/usr/bin/env bash
# Check if system time is in sync with NTP server

set -euo pipefail

echo "===== System Time Synchronization Check ====="

# Using timedatectl
if command -v timedatectl >/dev/null 2>&1; then
    echo "Checking via timedatectl..."
    timedatectl status | awk '
    /NTP enabled:/ {print $0}
    /System clock synchronized:/ {print $0}'
    echo
else
    echo "timedatectl not found."
fi

# Using chronyc (Chrony)
if command -v chronyc >/dev/null 2>&1; then
    echo "Checking via chronyc..."
    # Get NTP sources and their offsets
    chronyc tracking
    echo
else
    echo "chronyc (Chrony) not installed."
fi

# Optional: simple offset check
echo "Optional offset check (timedelta from NTP servers):"
if command -v chronyc >/dev/null 2>&1; then
    chronyc sources -v
elif command -v ntpq >/dev/null 2>&1; then
    ntpq -p
else
    echo "Neither chronyc nor ntpq available to check NTP offsets."
fi

echo "===== End of Check ====="
