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

