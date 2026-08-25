#!/bin/bash
cat /sys/class/hwmon/hwmon4/fan1_input 2>/dev/null | xargs -I{} echo "{} RPM"
