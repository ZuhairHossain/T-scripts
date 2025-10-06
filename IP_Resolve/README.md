# IP Resolution Script README

This document explains the usage and functionality of the `resolve_ips.sh` Bash script, which resolves a list of IP addresses to their hostnames.

---

## 1. Overview

`resolve_ips.sh` is a Bash script that accepts a list of IP addresses and resolves their hostnames using the `host` command. It handles errors gracefully and works with both command-line IP arguments and files containing IPs.

### Features

* Accepts IP addresses as command-line arguments or from a file.
* Resolves IPs to hostnames (PTR records).
* Handles unresolvable IPs and prints a clear message.
* Works for both public and private IPs.

---

## 2. Script Usage

### Running with command-line IPs

```bash
chmod +x resolve_ips.sh
./resolve_ips.sh 8.8.8.8 1.1.1.1 142.250.72.206
```

### Running with a file of IPs

Create a text file (e.g., `ips.txt`) containing one IP per line:

```bash
8.8.8.8
1.1.1.1
142.250.72.206
```

Run the script with:

```bash
./resolve_ips.sh -f ips.txt
```

### Sample Output

```bash
8.8.8.8 -> dns.google
1.1.1.1 -> one.one.one.one
142.250.72.206 -> lga34s10-in-f14.1e100.net
192.168.1.1 -> [No PTR record found]
```

---

## 3. Script Details

### Function: resolve_ip

```bash
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
```

* Uses `host` to query the PTR record.
* Checks for errors and prints a meaningful message if resolution fails.

### Input Handling

* `-f <file>` option reads IP addresses from a file.
* Otherwise, all command-line arguments are treated as IPs.
* Blank lines in the file are ignored.

---

## 4. Notes

* Requires the `host` command to be installed (usually part of `bind-utils` or `dnsutils`).
* Private IPs may not have PTR records; the script will indicate `[No PTR record found]`.
* All errors are handled gracefully to ensure continuous execution.

---

## 5. Example

```bash
# File: ips.txt
8.8.8.8
192.168.1.1

# Command
./resolve_ips.sh -f ips.txt

# Output
8.8.8.8 -> dns.google
192.168.1.1 -> [No PTR record found]
```

---

This script is useful for network administration, automated reports, or quick IP-to-hostname resolution tasks in Linux environments.
