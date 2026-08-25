#!/bin/bash

if pgrep -x wlsunset > /dev/null; then
  echo "󰖕"
else
  echo "󰖔"
fi
