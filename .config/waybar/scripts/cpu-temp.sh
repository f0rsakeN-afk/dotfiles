#!/bin/bash
temp=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo "0")
temp=$((temp / 1000))
echo " ${temp}°C"
