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

