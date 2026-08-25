#!/bin/bash
# Toggle projector mirror mode
# Super + M

PROJECTOR=$(hyprctl monitors | grep "HDMI-A" | awk '{print $1}')
BUILTIN="eDP-1"

if [ -z "$PROJECTOR" ]; then
    notify-send "Projector" "No projector detected" -u low
    exit 0
fi

# Check if already mirroring
CURRENT_MIRROR=$(hyprctl monitors | grep -A1 "$BUILTIN" | grep "mirrorOf" | awk '{print $2}')

if [ "$CURRENT_MIRROR" = "none" ]; then
    # Not mirroring - enable mirror mode
    hyprctl setmirror "$BUILTIN" "$PROJECTOR"
    notify-send "Projector" "Mirror mode ON" -u normal
else
    # Currently mirroring - disable it
    hyprctl setmirror "$BUILTIN" none
    notify-send "Projector" "Mirror mode OFF" -u normal
fi
