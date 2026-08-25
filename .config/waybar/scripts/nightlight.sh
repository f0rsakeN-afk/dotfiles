#!/bin/bash

if pgrep -x wlsunset > /dev/null; then
  pkill wlsunset
  echo "󰖔"   # off icon
else
  wlsunset -t 4000 &
  echo "󰖕"   # on icon
fi

