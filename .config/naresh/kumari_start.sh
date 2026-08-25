#!/bin/bash

KUMARI="/home/zara/desktop/kumari"
AGENTIC="$KUMARI/Kumari_Agentic_mode"
AGENTIC_MCP="$KUMARI/Agentic_mcp_server"
FRONTEND="$KUMARI/kumari-frontend"

# Workspace 1 - Chrome
hyprctl dispatch workspace 1
sleep 0.3
gtk-launch brave &

# Workspace 2 - Claude Desktop
hyprctl dispatch workspace 2
sleep 0.3
claude &

# Workspace 3 - Brave
hyprctl dispatch workspace 3
sleep 0.3
brave &

# Workspace 4 - 4 Ghostty terminals
hyprctl dispatch workspace 4
sleep 0.5

# Terminal 1 - Docker (kumari + redis)
ghostty -e bash -c "cd $KUMARI && docker start kumari redis 2>/dev/null || docker start kumari redis; exec bash" &
sleep 0.3

# Terminal 2 - Frontend (bun dev)
ghostty -e bash -c "cd $FRONTEND && bun dev; exec bash" &
sleep 0.3

# Terminal 3 - Backend
ghostty -e bash -c "cd $KUMARI && source .venv/bin/activate && uv run uvicorn src.main.app --reload; exec bash" &
sleep 0.3

# Terminal 4 - Agentic mode backend (port 7000)
ghostty -e bash -c "cd $AGENTIC && source .venv/bin/activate && uv run uvicorn src.sys.api.main:app --port 7000 --reload; exec bash" &
sleep 0.3

# Terminal 5 - Agentic MCP server (port 9000)
ghostty -e bash -c "cd $AGENTIC_MCP && source .venv/bin/activate && python -m uvicorn hub:hub_app --host 0.0.0.0 --port 9000 --reload; exec bash" &

# Return to workspace 1
hyprctl dispatch workspace 1
