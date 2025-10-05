# Time Synchronization Check Script README

This document explains the usage and functionality of the `check_time_sync.sh` script, which checks whether the system clock is synchronized with NTP servers.

---

## 1. Overview

`check_time_sync.sh` is a Bash script that monitors the system time and verifies whether it is in sync with network time servers. It uses both **timedatectl** and **chronyc** (Chrony) for checking synchronization.

### Features

* Checks system clock synchronization status via `timedatectl`.
* Checks NTP server tracking and offsets via `chronyc` (if Chrony is installed).
* Provides optional offset details from NTP servers using `chronyc sources` or `ntpq`.
* Gives clear, human-readable output.

---

## 2. Script Usage

### Make the script executable

```bash
chmod +x check_time_sync.sh
```

### Run the script

```bash
./check_time_sync.sh
```

### Sample Output

```bash
===== System Time Synchronization Check =====
Checking via timedatectl...
System clock synchronized: no

Checking via chronyc...
Reference ID    : 00000000 ()
Stratum         : 0
Ref time (UTC)  : Thu Jan 01 00:00:00 1970
System time     : 0.000000036 seconds slow of NTP time
Leap status     : Not synchronised

Optional offset check (timedelta from NTP servers):
^? ntp.example.com       2  10     3     -     +0ns[   +0ns] +/-    0ns
===== End of Check =====
```

* **System clock synchronized: no** → System is not synced with any NTP server.
* **Reference ID 00000000** and **Stratum 0** → No valid NTP server is being used.
* **Leap status: Not synchronised** → Chrony has not synchronized yet.

---

## 3. Common Issues and Fixes

### Not authorised when running `chronyc makestep`

* Error: `501 Not authorised` occurs because administrative commands require authorization from the chronyd daemon.

**Fixes:**

1. Run with automatic authorization:

```bash
sudo chronyc -a makestep
```

2. Update `/etc/chrony/chrony.conf` to allow localhost:

```bash
allow 127.0.0.1
allow ::1
```

Then restart:

```bash
sudo systemctl restart chronyd
```

3. Enable systemd timesyncd instead:

```bash
sudo timedatectl set-ntp true
timedatectl status
```

### NTP server unreachable

* Check network connectivity:

```bash
ping <ntp-server>
chronyc sources
```

* Make sure your firewall allows **UDP port 123** for NTP.

---

## 4. Commands Explained

| Command              | Purpose                                                |
| -------------------- | ------------------------------------------------------ |
| `timedatectl status` | Checks NTP synchronization via systemd-timesyncd       |
| `chronyc tracking`   | Shows Chrony NTP tracking and offset                   |
| `chronyc sources -v` | Lists NTP sources and their offsets                    |
| `ntpq -p`            | Alternative to view NTP peers and offsets              |
| `chronyc makestep`   | Immediately corrects system clock if significantly off |

---

## 5. Summary

* The script helps monitor whether your system time is accurate and in sync with network time servers.
* Correct NTP synchronization is critical for logs, scheduled jobs, security, and distributed systems.
* If synchronization fails, check Chrony status, network connectivity, and NTP server availability.
