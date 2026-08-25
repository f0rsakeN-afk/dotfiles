#!/bin/bash

IFACE="wlan0"  # change to your network interface

FILE="/tmp/.waybar_download_$IFACE"

if [ ! -f $FILE ]; then
    echo $(cat /sys/class/net/$IFACE/statistics/rx_bytes) > $FILE
    echo " 0 KB/s"
    exit
fi

OLD=$(cat $FILE)
NEW=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
DIFF=$((NEW - OLD))
echo $NEW > $FILE

# Convert to human-readable
if [ $DIFF -lt 1024 ]; then
    SPEED="${DIFF} B/s"
elif [ $DIFF -lt 1048576 ]; then
    SPEED=$(awk "BEGIN{printf \"%.1f KB/s\", $DIFF/1024}")
else
    SPEED=$(awk "BEGIN{printf \"%.1f MB/s\", $DIFF/1048576}")
fi

# Print with nice monochrome download icon
echo " $SPEED"

