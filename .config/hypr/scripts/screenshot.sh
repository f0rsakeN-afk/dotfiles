#!/usr/bin/env bash
grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')" "/home/zara/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"
