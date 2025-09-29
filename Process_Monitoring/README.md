
# Nginx Process Monitor Script

This project provides a Bash script to monitor the **nginx** process and automatically restart it if it is not running.  
It is designed to be used in production with **cron**.

---

## 1. Setup Nginx on Oracle Linux 8.10

```bash
sudo dnf install nginx -y
sudo systemctl start nginx
```

Verify that nginx is running:
```bash
systemctl status nginx
```

You can also check by visiting:
```
http://localhost
```

---

## 2. Install the Monitor Script

1. Copy the script to ``:
   ```bash
   sudo cp process_monitor.sh process_monitor.sh
   sudo chmod +x process_monitor.sh
   ```

2. Test manually:
   ```bash
   process_monitor.sh nginx nginx
   ```

3. View logs:
   ```bash
   cat process_monitor.log
   ```

---

## 3. Setup Cronjob

Edit root's crontab:
```bash
sudo crontab -e
```

Add this line to run the script every minute:
```bash
* * * * * process_monitor.sh nginx nginx
```

Save and exit. Cron will now monitor nginx continuously.

---

## 4. Logs

The script writes logs to:
```
process_monitor.log
```

This includes timestamps, restart attempts, and success/failure messages.

---

✅ The script is pre-configured for **nginx**, but you can adapt it to other services if needed.