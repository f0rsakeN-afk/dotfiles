#!/bin/bash
# GPU info script for waybar
# Shows Intel GPU frequency

GPU_PATH="/sys/devices/pci0000:00/0000:00:02.0/drm/card1"

act_freq=$(cat "$GPU_PATH/gt_act_freq_mhz" 2>/dev/null)
max_freq=$(cat "$GPU_PATH/gt_max_freq_mhz" 2>/dev/null)

if [ -z "$act_freq" ] || [ "$act_freq" = "0" ]; then
    echo " idle"
else
    echo " ${act_freq} MHz"
fi
