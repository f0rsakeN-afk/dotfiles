#!/bin/bash
SINK=$(pactl get-default-sink 2>/dev/null)
DESC=$(pactl list sinks 2>/dev/null | grep -A1 "Name: $SINK" | grep Description | sed 's/Description: //' | head -1)
if echo "$DESC" | grep -qi "headphone"; then
  echo ""
elif echo "$DESC" | grep -qi "speaker"; then
  echo ""
else
  echo ""
fi
