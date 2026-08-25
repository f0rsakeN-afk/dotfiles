#!/bin/bash

status=$(protonvpn-cli status 2>/dev/null | grep "Status" | awk '{print $2}')

if [ "$status" = "Connected" ]; then
    country=$(curl -s https://ipinfo.io/country)
    echo "🔒 $country"
else
    echo "🔓 OFF"
fi
