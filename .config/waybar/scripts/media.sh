#!/bin/bash

# Maximum length for display
MAXLEN=40

# Get current song info using playerctl
STATUS=$(playerctl status 2>/dev/null)

if [ "$STATUS" = "Playing" ]; then
    ARTIST=$(playerctl metadata artist 2>/dev/null)
    TITLE=$(playerctl metadata title 2>/dev/null)
    SONG="$ARTIST - $TITLE"
    # Trim if longer than MAXLEN
    if [ ${#SONG} -gt $MAXLEN ]; then
        SONG="${SONG:0:$MAXLEN}…"
    fi
    echo "$SONG"
elif [ "$STATUS" = "Paused" ]; then
    ARTIST=$(playerctl metadata artist 2>/dev/null)
    TITLE=$(playerctl metadata title 2>/dev/null)
    SONG="$ARTIST - $TITLE"
    if [ ${#SONG} -gt $MAXLEN ]; then
        SONG="${SONG:0:$MAXLEN}…"
    fi
    echo "$SONG"
else
    echo "🎶 Nothing playing"
fi

