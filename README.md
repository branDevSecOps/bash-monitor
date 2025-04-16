# 🖥️ Bash System Monitor

A lightweight, color-coded terminal dashboard written in Bash that shows live system resource usage and logs the output for historical tracking. Designed for Linux administrators and students building hands-on experience with real-world command-line tooling.

---

## 🚀 Features

- 🔍 Live monitoring of:
  - CPU load average (1, 5, 15 minutes)
  - RAM usage (MB & %)
  - Disk usage of root volume
  - Top 5 memory-consuming processes
  - Top 5 CPU-consuming processes
- ⚠️ Alerts when RAM or Disk exceed safe thresholds
- 📁 Saves full reports with timestamps into `/logs/`
- ✨ Color-coded for clarity
- 🧰 Simple Bash script, portable across distros

---

## 📂 File Structure

```
bash-monitor/
├── monitor.sh                # Main script
├── logs/                     # Saved output logs
├── .gitignore                # Ignores logs and temp files
└── README.md                 # This file
```

---

## 🛠️ How to Use

### 1. Clone the project
```bash
git clone https://github.com/<your-username>/bash-monitor.git
cd bash-monitor
```

### 2. Make the script executable
```bash
chmod +x monitor.sh
```

### 3. Run the monitor
```bash
./monitor.sh
```
Output will appear in terminal **and** be saved in:
```bash
./logs/system-report-YYYY-MM-DD_HH-MM-SS.log
```

---

## 🧠 Sample Output (colorized in terminal)

```
==============================
System Monitoring Dashboard
Host: your-vm | Time: 2024-04-16 19:30:00
==============================

--- CPU Load Average ---
Load (1/5/15 min): 0.15, 0.25, 0.30

--- Memory Usage (MB) ---
Used: 832MB | Total: 3936MB | Free: 2892MB

--- Disk Usage (root volume) ---
Used: 8.2G | Total: 30G | Free: 20G | Usage: 27%

--- RAM Usage Check ---
Current RAM usage: 832MB / 3936MB (21%)
✅ RAM usage is within safe range.

--- Top 5 Memory-Consuming Processes ---
user       1532     4.3   15.5   /usr/bin/python3
...

📁 Log saved to: logs/system-report-2024-04-16_19-30-00.log
```

---

## ⏰ Automate with Cron
To run the monitor daily and log to `/logs/`:
```bash
crontab -e
```
Add this line:
```bash
0 9 * * * /full/path/to/bash-monitor/monitor.sh
```

---

## 📌 Future Ideas
- [ ] Email or Slack alerts on threshold breach
- [ ] HTML/JSON export for dashboards
- [ ] Log rotation (keep only last 7 days)

---

## 👨‍💻 Author
**Brandon Lester**  
Cloud & Linux Enthusiast • YouTube: [Brandevops](https://www.youtube.com/@brandevops)

---

## 📜 License
MIT


