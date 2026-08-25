#!/bin/bash
window=$(hyprctl activewindow 2>/dev/null)
title=$(echo "$window" | grep "title:" | sed 's/.*title: *//' | cut -c1-50)
class=$(echo "$window" | grep "class:" | sed 's/.*class: *//')
if [ -z "$title" ] || [ "$title" = "null" ]; then
  echo ""
else
  echo " $class: $title "
fi
