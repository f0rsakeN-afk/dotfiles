#!/bin/bash

# Kill all related processes
pkill -f "brave" 2>/dev/null
pkill -f "claude" 2>/dev/null
pkill -f "kumari-frontend" 2>/dev/null
pkill -f "uvicorn src.main.app" 2>/dev/null
pkill -f "uvicorn src.sys.api.main" 2>/dev/null
pkill -f "uvicorn hub:hub_app" 2>/dev/null

# Stop docker containers
docker stop kumari redis 2>/dev/null

# Return to workspace 1
hyprctl dispatch workspace 1
