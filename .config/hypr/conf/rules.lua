-- rules.lua

-- Window opacity
local opacity_apps = {
    "kitty", "brave.*", "code", "zed", "spotify",
    "thunar", "discord", "codium", "obsidian", "pavucontrol", "foliate",
}

for _, app in ipairs(opacity_apps) do
    hl.window_rule({
        name = "opacity",
        match = { class = "^(" .. app .. ")$" },
        opacity = "0.7 override 0.7 override 1.0 override",
    })
end

-- Rofi blur
hl.layer_rule({
    match = { namespace = "rofi" },
    blur = true,
    ignore_alpha = 0.15,
})

-- Blur other
hl.layer_rule({ match = { class = "waybar" }, blur = true })
hl.layer_rule({ match = { class = "logout_dialog" }, blur = true })
hl.layer_rule({ match = { class = "swaync-control-center" }, blur = true })
hl.layer_rule({ match = { class = "swaync-notification-window" }, blur = true })
hl.layer_rule({ match = { class = "swaync-control-center" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { class = "swaync-notification-window" }, ignore_alpha = 0.5 })

-- Float dialogs
hl.window_rule({ name = "float-pavu", match = { class = "pavucontrol" }, float = true })
hl.window_rule({ name = "float-nm", match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({ name = "float-blueman", match = { class = "blueman-manager" }, float = true })
hl.window_rule({ name = "float-open", match = { title = "^(Open File)$" }, float = true })
hl.window_rule({ name = "float-save", match = { title = "^(Save File)$" }, float = true })

-- Disable blur on floating XWayland
hl.window_rule({ name = "no-blur-xwl", match = { class = "xwayland:1", float = true }, no_blur = true })

-- General decoration
hl.general({
    gaps_in = 2,
    gaps_out = 4,
    border_size = 2,
    col_active_border = "$color2",
    col_inactive_border = "$color8",
    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
})

hl.decoration({
    rounding = 1,
    rounding_power = 1,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = {
        enabled = true,
        range = 4,
        render_power = 3,
        color = "$color0",
    },
    blur = {
        enabled = true,
        size = 6,
        passes = 3,
        new_optimizations = true,
        ignore_opacity = true,
    },
})
