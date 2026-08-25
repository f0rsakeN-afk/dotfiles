#!/bin/bash
uptime -p 2>/dev/null | sed 's/up //;s/ hours*/h/;s/ minutes*/m/;s/ hour*/h/;s/,//' || uptime | awk '{print $3,$4}' | tr -d ','
