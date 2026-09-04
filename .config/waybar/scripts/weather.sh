#!/bin/bash

API_KEY="${OPENWEATHER_API_KEY:?Set OPENWEATHER_API_KEY in your environment}"
CITY_ID="1283582"
UNIT="metric"

# Fetch current weather
WEATHER=$(curl -s "https://api.openweathermap.org/data/2.5/weather?id=$CITY_ID&appid=$API_KEY&units=$UNIT")
FORECAST=$(curl -s "https://api.openweathermap.org/data/2.5/forecast?id=$CITY_ID&appid=$API_KEY&units=$UNIT")

# Current
TEMP=$(echo $WEATHER | jq '.main.temp' | awk '{printf "%.0f", $1}')
HUMIDITY=$(echo $WEATHER | jq '.main.humidity')
WIND=$(echo $WEATHER | jq '.wind.speed' | awk '{printf "%.0f", $1}')
COND=$(echo $WEATHER | jq -r '.weather[0].main')
DESC=$(echo $WEATHER | jq -r '.weather[0].description')

case $COND in
    Clear) ICON="☀️" ;;
    Clouds) ICON="☁️" ;;
    Rain) ICON="🌧️" ;;
    Drizzle) ICON="🌦️" ;;
    Thunderstorm) ICON="⛈️" ;;
    Snow) ICON="❄️" ;;
    Mist|Fog|Haze) ICON="🌫️" ;;
    *) ICON="🌡️" ;;
esac

# Today's high/low from first forecast entry
TODAY=$(date +%Y-%m-%d)
TODAY_MIN=$(echo "$FORECAST" | jq -r ".list[] | select(.dt_txt | startswith(\"$TODAY\")) | .main.temp_min" | sort -n | head -1 | awk '{printf "%.0f", $1}')
TODAY_MAX=$(echo "$FORECAST" | jq -r ".list[] | select(.dt_txt | startswith(\"$TODAY\")) | .main.temp_max" | sort -n | tail -1 | awk '{printf "%.0f", $1}')

# Tomorrow's forecast
TOMORROW=$(date -d "+1 day" +%Y-%m-%d)
TOMO_DATA=$(echo "$FORECAST" | jq -r ".list[] | select(.dt_txt | startswith(\"$TOMORROW\"))")
TOMO_MIN=$(echo "$TOMO_DATA" | jq -r '.main.temp_min' | sort -n | head -1 | awk '{printf "%.0f", $1}')
TOMO_MAX=$(echo "$TOMO_DATA" | jq -r '.main.temp_max' | sort -n | tail -1 | awk '{printf "%.0f", $1}')
TOMO_COND=$(echo "$TOMO_DATA" | jq -r 'select(.dt_txt) | .weather[0].main' 2>/dev/null | head -1)

case $TOMO_COND in
    Clear) TOMO_ICON="☀️" ;;
    Clouds) TOMO_ICON="☁️" ;;
    Rain) TOMO_ICON="🌧️" ;;
    Drizzle) TOMO_ICON="🌦️" ;;
    Thunderstorm) TOMO_ICON="⛈️" ;;
    Snow) TOMO_ICON="❄️" ;;
    Mist|Fog|Haze) TOMO_ICON="🌫️" ;;
    *) TOMO_ICON="🌡️" ;;
esac

# Tooltip with full info
TOOLTIP="📍 Biratnagar

🌡️ Now: $ICON ${TEMP}°C ($DESC)
💧 Humidity: $HUMIDITY%
💨 Wind: ${WIND}m/s

📅 Today: $ICON ${TODAY_MIN}° / ${TODAY_MAX}°

🌤️ Tomorrow: $TOMO_ICON ${TOMO_MIN}° / ${TOMO_MAX}°"

echo "{\"text\": \"$ICON ${TEMP}°\", \"tooltip\": \"$TOOLTIP\"}"
