#!/bin/bash
# Generates waybar colors from pywal with good contrast

WAL_CACHE=~/.cache/wal/colors.css
OUT_FILE=~/.cache/wal/colors-waybar.css

if [ ! -f "$WAL_CACHE" ]; then
    exit 1
fi

# Extract colors from pywal CSS
BG=$(grep -oP 'background:\s*\K[^;]+' "$WAL_CACHE" | head -1)
FG=$(grep -oP 'foreground:\s*\K[^;]+' "$WAL_CACHE" | head -1)
C0=$(grep -oP 'color0:\s*\K[^;]+' "$WAL_CACHE" | head -1)
C7=$(grep -oP 'color7:\s*\K[^;]+' "$WAL_CACHE" | head -1)
C15=$(grep -oP 'color15:\s*\K[^;]+' "$WAL_CACHE" | head -1)

# Ensure good contrast - use brightest for fg, darkest for bg
BG_CONTRAST=${C0:-#1b2125}
FG_CONTRAST=${C15:-$FG}

# Create waybar colors file with high contrast
cat > "$OUT_FILE" << EOF
@define-color background ${BG_CONTRAST};
@define-color foreground ${FG_CONTRAST};
@define-color select     ${C7};

@define-color pink       #f5c2e7;
@define-color purple     #cba6f7;
@define-color red        #f38ba8;
@define-color orange     #fab387;
@define-color yellow     #f9e2af;
@define-color green      #a6e3a1;
@define-color blue       #89b4fa;
@define-color gray       ${C7};
@define-color magenta    #ff6f91;
@define-color lime       #b8e986;
@define-color navy       ${BG_CONTRAST};
@define-color olive      #708238;
@define-color maroon     #800000;
@define-color turquoise  #40e0d0;
@define-color indigo     #4b0082;
@define-color coral      #ff7f50;
@define-color gold       #ffd700;
@define-color slate      #708090;
@define-color peach      #ffdab9;
@define-color crimson    #dc143c;
@define-color teal-dark  #008080;
EOF

echo "Waybar colors updated with good contrast"
