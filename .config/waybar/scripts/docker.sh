#!/bin/bash
count=$(docker ps --format '{{.Names}}' 2>/dev/null | wc -l)
names=$(docker ps --format '{{.Names}}' 2>/dev/null | tr '\n' ' ')

if [ "$count" -gt 0 ]; then
  echo " ${count}"
  echo "$names" >&2
else
  echo ""
fi
