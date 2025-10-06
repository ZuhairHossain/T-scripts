#!/usr/bin/env bash
# Resolve IP addresses to hostnames

set -euo pipefail

resolve_ip() {
    local ip="$1"
    local output
    if output=$(host "$ip" 2>/dev/null); then
        local hostname
        hostname=$(echo "$output" | awk '/pointer/ {print $5}' | sed 's/\.$//')
        if [[ -n "$hostname" ]]; then
            echo "$ip -> $hostname"
        else
            echo "$ip -> [No PTR record found]"
        fi
    else
        echo "$ip -> [Could not resolve]"
    fi
}

# --- Input parsing ---
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <IP1> <IP2> ... or $0 -f ip_list.txt"
    exit 1
fi

# If -f flag is used, read IPs from file
if [[ "$1" == "-f" ]]; then
    if [[ $# -ne 2 ]]; then
        echo "Usage: $0 -f ip_list.txt"
        exit 1
    fi
    ip_file="$2"
    if [[ ! -f "$ip_file" ]]; then
        echo "File '$ip_file' not found."
        exit 1
    fi
    mapfile -t ips < "$ip_file"
else
    ips=("$@")
fi

# --- Resolve each IP ---
for ip in "${ips[@]}"; do
    resolve_ip "$ip"
done
