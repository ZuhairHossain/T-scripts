# List Bash Users Script README

This document explains the usage and functionality of the `list_users_shells.sh` script, which lists all users on the system whose login shell is `/bin/bash`.

---

## 1. Overview

`list_users_shells.sh` is a Bash script designed to:

* Parse `/etc/passwd`
* Identify users whose login shell is `/bin/bash`
* Display them in a formatted table along with a total count

This is useful for system administration tasks where you want to know which users have shell access.

---

## 2. Script: `list_users_shells.sh`

```bash
#!/bin/bash
# ========================================================
# Script Name: list_users_shells.sh
# Description: Lists all users whose login shell is /bin/bash
# Author: Syed Zuhair Hossain
# Version: 1.1
# ========================================================

set -euo pipefail

PASSWD_FILE="/etc/passwd"

# Ensure /etc/passwd is readable
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
```

---

## 3. Usage

1. **Make the script executable**

```bash
chmod +x list_users_shells.sh
```

2. **Run the script**

```bash
./list_users_shells.sh
```

### Example Output

```
============================================
Users with /bin/bash shell
--------------------------------------------
root                 | /bin/bash
zuhairhossain        | /bin/bash
============================================
Total Bash Users: 2
```

---

## 4. Notes

* Only users with `/bin/bash` as their login shell are listed.
* Works on any Unix/Linux system with `/etc/passwd` accessible.
* No root privileges are required; only read access to `/etc/passwd`.
* A one-liner alternative is also available:

```bash
awk -F: '$7 == "/bin/bash" {print $1}' /etc/passwd
```
