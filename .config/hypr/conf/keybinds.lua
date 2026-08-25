-- keybinds.lua

local mainMod = "SUPER"

-- Launcher / hints
hl.bind(mainMod, "H", hl.exec_cmd("~/.config/zara/key_hints.sh"))
hl.bind(mainMod, "Space", hl.exec_cmd("$terminal"))
hl.bind(mainMod, "E", hl.exec_cmd("$fileManager"))
hl.bind(mainMod, "B", hl.exec_cmd("$browser"))

-- Exit / kill
hl.bind(mainMod .. " Shift Control", "Escape", hl.exit())
hl.bind(mainMod, "Q", hl.killactive())
hl.bind(mainMod .. " Shift", "Q", hl.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))

-- Layout
hl.bind(mainMod, "P", hl.pseudo())
hl.bind(mainMod, "L", hl.exec_cmd("hyprlock"))

-- Custom scripts
hl.bind("Alt", "Space", hl.exec_cmd("~/.config/zara/app_launcher.sh"))
hl.bind(mainMod, "PERIOD", hl.exec_cmd("~/.config/zara/emoji_launcher.sh"))
hl.bind(mainMod, "V", hl.exec_cmd("~/.config/zara/clipboard_launcher.sh"))
hl.bind(mainMod, "T", hl.exec_cmd("~/.config/waybar/scripts/toggle.sh"))
hl.bind(mainMod, "K", hl.exec_cmd("~/.config/zara/kumari_start.sh"))
hl.bind(mainMod .. " Shift", "K", hl.exec_cmd("~/.config/zara/kumari_stop.sh"))
hl.bind(mainMod, "W", hl.exec_cmd("~/.config/zara/wallpaper_select.sh"))
hl.bind(mainMod .. " Shift", "W", hl.exec_cmd("~/.config/zara/wallpaper_random.sh"))
hl.bind(mainMod .. " Shift", "S", hl.exec_cmd("hyprshot -m region -o $HOME/Pictures/Screenshots"))

-- Focus
hl.bind(mainMod, "left", hl.movefocus("l"))
hl.bind(mainMod, "right", hl.movefocus("r"))
hl.bind(mainMod, "up", hl.movefocus("u"))
hl.bind(mainMod, "down", hl.movefocus("d"))

-- Workspaces
for i = 1, 10 do
    hl.bind(mainMod, tostring(i), hl.workspace(i))
    hl.bind(mainMod .. " SHIFT", tostring(i), hl.movetoworkspace(i))
end

-- Scroll workspaces
hl.bind(mainMod, "mouse_down", hl.workspace("e+1"))
hl.bind(mainMod, "mouse_up", hl.workspace("e-1"))

-- Move/resize
hl.bindm(mainMod, "mouse:272", hl.movewindow())
hl.bindm(mainMod, "mouse:273", hl.resizewindow())

-- Media keys
hl.bindel(",XF86AudioRaiseVolume", hl.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bindel(",XF86AudioLowerVolume", hl.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bindel(",XF86AudioMute", hl.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bindel(",XF86AudioMicMute", hl.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bindel(",XF86MonBrightnessUp", hl.exec_cmd("brightnessctl s 10%+"))
hl.bindel(",XF86MonBrightnessDown", hl.exec_cmd("brightnessctl s 10%-"))
hl.bindl(",XF86AudioNext", hl.exec_cmd("playerctl next"))
hl.bindl(",XF86AudioPause", hl.exec_cmd("playerctl play-pause"))
hl.bindl(",XF86AudioPlay", hl.exec_cmd("playerctl play-pause"))
hl.bindl(",XF86AudioPrev", hl.exec_cmd("playerctl previous"))

-- Projector
hl.bind(mainMod, "M", hl.exec_cmd("~/.config/zara/projector_toggle.sh"))
hl.bind(mainMod .. " Shift", "M", hl.movetoworkspace("2", "HDMI-A-1"))
hl.bind(mainMod, "O", hl.focusmonitor("HDMI-A-1"))
hl.bind(mainMod .. " Shift", "O", hl.movewindow("HDMI-A-1"))
