#!/bin/bash

# Read total and free swap in kB
TOTAL=$(awk '/SwapTotal/ {print $2}' /proc/meminfo)
FREE=$(awk '/SwapFree/ {print $2}' /proc/meminfo)

USED=$((TOTAL - FREE))

# Convert to GB with 1 decimal
used_gb=$(awk "BEGIN {printf \"%.1f\", $USED/1024/1024}")
total_gb=$(awk "BEGIN {printf \"%.1f\", $TOTAL/1024/1024}")

echo "󰓡 $used_gb/$total_gb G"

