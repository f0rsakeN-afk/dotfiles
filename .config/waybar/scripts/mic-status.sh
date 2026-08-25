#!/bin/bash
SOURCE=$(pactl get-default-source 2>/dev/null)
if pactl get-source-mute "$SOURCE" 2>/dev/null | grep -q "yes"; then
  echo "󰍭"
else
  echo "󰍬"
fi
