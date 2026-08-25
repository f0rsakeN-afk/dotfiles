-- ~/.config/hypr/hyprland.lua

---- VARIABLES ----
mainMod = "SUPER"
terminal = "ghostty"
fileManager = "nemo"
browser = "brave"
menu = "rofi -show drun"

---- AUTOSTART ----
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("fcitx5")
end)

---- ENVIRONMENT ----
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

---- INPUT ----
hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 1,
        accel_profile = "flat",
        touchpad = {
            natural_scroll = true,
            scroll_factor = 3,
        },
    },
})

---- DEVICE ----
hl.device({ name = "epic-mouse-v1", sensitivity = 1 })

---- GESTURES ----
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

---- DECORATION / LOOK ----
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 4,
        border_size = 2,
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 1,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            vibrancy = 0.2,
        },
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
        },
    },
    animations = {
        enabled = true,
    },
})

---- ANIMATIONS ----
hl.curve("ease", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1.0} } })
hl.curve("overshot", { type = "bezier", points = { {0.13, 0.99}, {0.29, 1.05} } })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "overshot" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "ease", space = "slide bottom" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "overshot" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "ease" })
hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "ease" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot" })

---- LAYOUT ----
hl.config({
    dwindle = { preserve_split = true },
    master = { new_status = "master" },
})

---- MISC ----
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        initial_workspace_tracking = 1,
        enable_std_sockets = true,
    },
})

---- MONITORS ----
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = "1" })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = "1", mirror = "eDP-1" })

---- KEYBINDS & RULES ----
require("keybinds")
require("rules")
