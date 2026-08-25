#!/bin/bash
# Disk usage script for waybar

df -h / | awk 'NR==2 {print $3 "/" $2}'
