# Enhanced System Monitoring Menu Script README

This document explains the usage, features, and functionality of the `menu_script.sh` Bash script, which provides an interactive system monitoring menu.

---

## 1. Overview

`menu_script.sh` is a Bash script designed to help users monitor their Linux system quickly through an interactive menu. It allows you to check disk usage, memory, CPU, network info, logged-in users, system uptime, and more, all from a simple menu interface.

### Features:

* Interactive menu with numbered options.
* Displays system information in a user-friendly way.
* Highlights options using colors for better readability.
* Loops until the user chooses to exit.

---

## 2. Script Usage

### Make the script executable:

```bash
chmod +x menu_script.sh
```

### Run the script:

```bash
./menu_script.sh
```

### Menu Options:

1. **Disk Usage** → Shows usage of all mounted filesystems (`df -h`).
2. **Memory Usage** → Displays RAM and swap usage (`free -h`).
3. **CPU Usage (Top 10)** → Shows the top 10 CPU-consuming processes (`top -bn1 | head -n 10`).
4. **Top Memory-Consuming Processes** → Lists the top 10 processes by memory usage (`ps aux --sort=-%mem | head -n 10`).
5. **Network Info** → Displays network interfaces and IP addresses (`ip addr`).
6. **Logged-in Users** → Shows currently logged-in users (`who`).
7. **System Uptime** → Shows how long the system has been running (`uptime`).
8. **Exit** → Exit the menu.

---

## 3. Example Run

```
================== System Menu ==================
1) Disk Usage
2) Memory Usage
3) CPU Usage (Top 10)
4) Top Memory-Consuming Processes
5) Network Info
6) Logged-in Users
7) System Uptime
8) Exit
=================================================
Enter your choice [1-8]: 1

Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       50G   25G   23G  52% /
...

Press Enter to return to the menu...
```

The menu will redisplay until the user selects option 8 to exit.

---

## 4. Notes

* Requires Bash and standard Linux commands (`df`, `free`, `top`, `ps`, `ip`, `who`, `uptime`).
* Works on most Linux distributions.
* Colors are ANSI escape codes; terminals that do not support them will display raw codes.
* Can be enhanced to include additional system checks (disk cleanup, logs viewer, open ports).

---

## 5. Enhancements You Can Add

* Monitor a specific process by name.
* Check open ports using `ss -tuln` or `netstat -tuln`.
* View recent system logs (`tail -n 20 /var/log/syslog`).
* Disk cleanup suggestions (show large files with `du -h --max-depth=1`).

---

This script is designed for day-to-day system monitoring and makes it easier to check system health without remembering multiple commands.
