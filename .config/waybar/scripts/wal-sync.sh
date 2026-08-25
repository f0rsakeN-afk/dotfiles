#!/bin/bash
# Full theme sync from pywal - 43PR glassy style

WAL_CACHE=~/.cache/wal

# Update waybar colors
~/.config/waybar/scripts/wal-colors.sh

# Update rofi colors dynamically
if [ -f "$WAL_CACHE/colors.css" ]; then
    BG=$(grep -oP 'background:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)
    FG=$(grep -oP 'foreground:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)
    C1=$(grep -oP 'color1:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)
    C7=$(grep -oP 'color7:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)
    C9=$(grep -oP 'color9:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)
    C15=$(grep -oP 'color15:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)

    # Darken bg for rofi glass effect
    BG_ROFI="#00000099"

    cat > ~/.config/rofi/config.rasi << EOF
configuration {
    modes: "drun";
    drun-display-format: "{name}";
    font: "Iosevka 13";
    location: 0;
    fixed-num-lines: true;
    show-icons: true;
    sidebar-mode: false;
    scroll-method: 1;
    matching: "prefix";
    sort: true;
    sorting-method: "normal";
    click-to-exit: true;

    display-run: "";
    display-window: "󰖯";
    display-drun: "";
    display-combi: "󰘔";
}

* {
    bg: ${BG_ROFI};
    bg-alt: #00000000;
    bg-hover: ${C1}33;
    bg-selected: ${C1}33;
    fg: ${FG};
    fg-muted: ${C7}99;
    fg-dark: ${C7};
    accent: ${C1};
    accent-soft: ${C1}33;
    urgent: ${C9};
    border-color: #FFFFFF00;

    background-color: transparent;
    text-color: @fg;
    margin: 0;
    padding: 0;
    spacing: 0;
}

window {
    location: center;
    width: 420px;
    height: 420px;
    background-color: @bg;
    border: 2px;
    border-color: @border-color;
    border-radius: 18px;
    padding: 10;
}

mainbox {
    orientation: vertical;
    background-color: transparent;
    spacing: 12px;
}

inputbar {
    background-color: @bg-alt;
    border: 1px;
    border-color: @border-color;
    border-radius: 12px;
    padding: 5px 15px;
    spacing: 12px;
    children: [prompt, entry];
}

prompt {
    enabled: true;
    background-color: transparent;
    text-color: @accent;
    font: "Iosevka Nerd Font 16";
    padding: 0;
    vertical-align: 0.5;
}

entry {
    background-color: transparent;
    text-color: @fg;
    font: "Iosevka 14";
    placeholder: "";
    placeholder-color: @fg-muted;
    padding: 0;
    vertical-align: 0.5;
    horizontal-align: 0.5;
}

listview {
    background-color: transparent;
    border: 0;
    spacing: 6px;
    padding: 4px 0;
    lines: 8;
    columns: 1;
    fixed-height: true;
    scrollbar: false;
}

element {
    background-color: transparent;
    border: 0;
    border-radius: 10px;
    padding: 10px 14px;
    spacing: 14px;
}

element-icon {
    size: 28px;
    background-color: transparent;
    vertical-align: 0.5;
}

element-text {
    background-color: transparent;
    text-color: inherit;
    vertical-align: 0.5;
    font: "Iosevka 11";
}

element normal.normal,
element alternate.normal {
    background-color: transparent;
    text-color: @fg;
}

element normal.active,
element alternate.active {
    background-color: transparent;
    text-color: @accent;
}

element normal.urgent,
element alternate.urgent {
    background-color: transparent;
    text-color: @urgent;
}

element selected.normal,
element selected.active {
    background-color: @bg-selected;
    text-color: @fg-dark;
}

element selected.urgent {
    background-color: @urgent;
    text-color: @fg-dark;
}

message {
    background-color: transparent;
    border: 0;
    padding: 4px 8px;
    text-color: @fg-muted;
}

textbox {
    background-color: transparent;
    text-color: @fg-muted;
    horizontal-align: 0.0;
}

sidebar {
    background-color: transparent;
    border: 0;
    padding: 0;
}

button {
    background-color: @bg-alt;
    text-color: @fg-muted;
    border: 1px;
    border-color: @border-color;
    border-radius: 10px;
    padding: 10px 14px;
    margin: 2px;
}

button selected {
    background-color: @accent-soft;
    text-color: @accent;
    border-color: @accent;
}

scrollbar {
    width: 4px;
    border: 0;
    handle-color: @accent;
    handle-width: 4px;
    padding: 0;
}

case-indicator {
    spacing: 0;
    text-color: @fg-muted;
}

textbox-prompt-colon {
    expand: false;
    str: "";
    text-color: inherit;
}
EOF
fi

# Update swaync colors
if [ -f "$WAL_CACHE/colors.css" ]; then
    C0=$(grep -oP 'color0:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)
    C7=$(grep -oP 'color7:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)
    C15=$(grep -oP 'color15:\s*\K[^;]+' "$WAL_CACHE/colors.css" | head -1)

    cat > ~/.config/swaync/colors.css << EOF
@define-color background ${C0};
@define-color foreground ${C15};
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
@define-color navy       ${C0};
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
    killall swaync 2>/dev/null
    swaync &
fi

echo "Theme synced"
