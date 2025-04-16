#!/bin/bash

# ===============================
# Bash System Monitoring Script
# ===============================
# Author: Brandon Lester
# Description: Displays live system metrics — CPU, memory, disk, uptime, top processes.
# Intended for sysadmins and learners to understand system resource usage.

# Colors for readability (ANSI escape codes)
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get system hostname and current time
HOSTNAME=$(hostname)
DATE=$(date +"%Y-%m-%d %H:%M:%S")

echo -e "${CYAN}=============================="
echo -e "System Monitoring Dashboard"
echo -e "Host: ${HOSTNAME} | Time: ${DATE}"
echo -e "==============================${NC}"

# Function to print section headers
section() {
  echo -e "\n${YELLOW}--- $1 ---${NC}"
}

# ========== CPU Load ==========
section "CPU Load Average"
# Get load average from uptime
uptime | awk -F'load average:' '{ print "Load (1/5/15 min):" $2 }'

# ========== Memory Usage ==========
section "Memory Usage (MB)"
# Use 'free' and extract used/total memory
free -m | awk 'NR==2{ printf "Used: %sMB | Total: %sMB | Free: %sMB\n", $3, $2, $4 }'

# ========== Disk Usage ==========
section "Disk Usage (root volume)"
# Get disk space info for root (/) only
df -h / | awk 'NR==2 { printf "Used: %s | Total: %s | Free: %s | Usage: %s\n", $3, $2, $4, $5 }'

# ========== Top 5 Memory-Hungry Processes ==========
section "Top 5 Memory-Consuming Processes"
ps aux --sort=-%mem | awk 'NR<=6{ printf "%-10s %-8s %-6s %-6s %s\n", $1, $2, $3, $4, $11 }'

# ========== Top 5 CPU-Hungry Processes ==========
section "Top 5 CPU-Consuming Processes"
ps aux --sort=-%cpu | awk 'NR<=6{ printf "%-10s %-8s %-6s %-6s %s\n", $1, $2, $3, $4, $11 }'

# ========== RAM Alert ==========
section "RAM Usage Check"

# Extract total and used memory in MB
MEM_TOTAL=$(free -m | awk 'NR==2 {print $2}')
MEM_USED=$(free -m | awk 'NR==2 {print $3}')
MEM_PERCENT=$(( 100 * MEM_USED / MEM_TOTAL ))

echo -e "Current RAM usage: ${MEM_USED}MB / ${MEM_TOTAL}MB (${MEM_PERCENT}%)"

if [ "$MEM_PERCENT" -gt 80 ]; then
  echo -e "${RED}⚠️ ALERT: RAM usage exceeds 80%!${NC}"
else
  echo -e "${GREEN}✅ RAM usage is within safe range.${NC}"
fi

# ========== Disk Alert ==========
section "Disk Usage Check"

# Get disk usage % for root volume (strip % sign)
DISK_PERCENT=$(df / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')
echo -e "Root disk usage: ${DISK_PERCENT}%"

if [ "$DISK_PERCENT" -gt 85 ]; then
  echo -e "${RED}⚠️ ALERT: Disk usage exceeds 85%!${NC}"
else
  echo -e "${GREEN}✅ Disk usage is within safe range.${NC}"
fi

# ========== Logging Setup ==========
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/system-report-$(date +'%Y-%m-%d_%H-%M-%S').log"

# Redirect everything printed with 'echo' to tee (logs + stdout)
exec > >(tee -a "$LOG_FILE") 2>&1

