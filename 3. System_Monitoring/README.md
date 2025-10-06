# System Monitor Script

This Bash script monitors CPU and RAM usage and writes it to a daily log file every 10 seconds. Logs are saved in the current directory with the filename format `hostname_IP_YYYY-MM-DD.log`.

## Features
- Logs CPU and RAM usage every 10 seconds.
- Log filename includes hostname and IP address.
- Automatically deletes log files older than 15 days.

## Usage
1. Make the script executable:
```bash
chmod +x system_monitor.sh
```

2. Run the script:
```bash
./system_monitor.sh &
```

3. Logs will appear in the current directory with names like:
```
myhost_192.168.1.10_2025-09-29.log
```

## Notes
- To stop the script, use `kill` on the process ID.
- Ensure the script is running in a directory where you have write permission.
- The script deletes logs older than 15 days automatically.