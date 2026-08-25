#!/bin/bash
window=$(hyprctl activewindow 2>/dev/null)
title=$(echo "$window" | grep "title:" | sed 's/.*title: *//' | cut -c1-50)
class=$(echo "$window" | grep "class:" | sed 's/.*class: *//')

# Build possible desktop file names from class
desktop_file=$(echo "$class" | tr '.' '-')
desktop_paths=(
    "$HOME/.local/share/applications/${desktop_file}.desktop"
    "$HOME/.local/share/applications/${class}.desktop"
    "/usr/share/applications/${desktop_file}.desktop"
    "/usr/share/applications/${class}.desktop"
)

icon=""
for path in "${desktop_paths[@]}"; do
    if [ -f "$path" ]; then
        icon=$(grep "^Icon=" "$path" 2>/dev/null | head -1 | cut -d= -f2)
        break
    fi
done

# Resolve icon name to absolute path
if [ -n "$icon" ] && [ "${icon:0:1}" != "/" ]; then
    icon_path=$(find /usr/share/icons /home/*/.local/share/icons -name "${icon}.*" 2>/dev/null | grep -E "24x24|32x32" | head -1)
    icon="$icon_path"
fi

if [ -z "$title" ] || [ "$title" = "null" ]; then
  echo ""
elif [ -n "$icon" ]; then
  echo "<img path='$icon' /> $title"
else
  echo "$title"
fi
