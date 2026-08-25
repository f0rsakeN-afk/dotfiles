#!/bin/bash

BACKLIGHT="/sys/class/backlight/intel_backlight"  # replace if yours is different

# Read max and current brightness
MAX=$(cat $BACKLIGHT/max_brightness)
CUR=$(cat $BACKLIGHT/brightness)

# Calculate percentage
PERC=$(awk "BEGIN {printf \"%d\", ($CUR/$MAX)*100}")

# Choose icon
if [ $PERC -lt 33 ]; then
    ICON=""   # dim
elif [ $PERC -lt 66 ]; then
    ICON=""   # medium
else
    ICON=""   # bright
fi

echo "$ICON $PERC%"

