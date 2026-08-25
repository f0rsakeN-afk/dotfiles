-- autostart.lua
local home = os.getenv("HOME")

hl.exec_on("waybar")
hl.exec_on("swaync")
hl.exec_on("awww-daemon & sleep 0.5 & swww init")
hl.exec_on("nm-applet --indicator")

-- fcitx5
hl.exec_on("export GTK_IM_MODULE=fcitx5")
hl.exec_on("export QT_IM_MODULE=fcitx5")
hl.exec_on("export XMODIFIERS=@im=fcitx5")
hl.exec_on("export INPUT_METHOD=fcitx5")
hl.exec_on("export SDL_IM_MODULE=fcitx5")
hl.exec_on("fcitx5")

-- screen sharing
hl.exec_on("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
hl.exec_on("/usr/lib/xdg-desktop-portal")
hl.exec_on("/usr/lib/xdg-desktop-portal-hyprland")

-- clipboard
hl.exec_on("wl-paste --type text --watch cliphist store")
hl.exec_on("wl-paste --type image --watch cliphist store")

-- themes
hl.exec_on(home .. "/.config/zara/gtkthemes.sh")
