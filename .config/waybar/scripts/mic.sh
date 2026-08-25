#!/bin/bash

SOURCE=$(pactl get-default-source)

if pactl get-source-mute "$SOURCE" | grep -q "yes"; then
  pactl set-source-mute "$SOURCE" 0
  echo "󰍬"   # mic ON
else
  pactl set-source-mute "$SOURCE" 1
  echo "󰍭"   # mic MUTED
fi

