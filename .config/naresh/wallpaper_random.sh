#!/usr/bin/env bash

wallpapers_dir="$HOME/Pictures/Wallpapers"

random_wallpaper=$(find "$wallpapers_dir" -maxdepth 1 -type f | shuf -n 1)

wal -i "$random_wallpaper" -n -e
awww img "$random_wallpaper" --transition-type any --transition-duration 2

~/.config/waybar/scripts/wal-sync.sh

~/.config/naresh/wallpaper_effects.sh
