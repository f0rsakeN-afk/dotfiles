#!/bin/bash
# System load script for waybar

load=$(cat /proc/loadavg | awk '{print $1}')
cpus=$(nproc 2>/dev/null || echo "1")

# Icon based on load level
icon=""

# Calculate load per core
load_per_core=$(echo "scale=1; $load / $cpus" | bc 2>/dev/null || echo "$load")

echo "${icon} ${load}"
