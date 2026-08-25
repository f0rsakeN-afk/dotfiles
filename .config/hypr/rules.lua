-- rules.lua

local window_opacity = 0.7

hl.layer_rule({
    match = { namespace = "rofi" },
    blur = true,
    ignore_alpha = 0.15,
})

hl.window_rule({
    name = "opacity-apps",
    match = {
        class = "^(kitty|brave-browser|com.brave.Browser|zen|zen-browser|chrome|google-chrome|chromium|com.google.Chrome|code|zed|spotify|thunar|discord|codium|obsidian|pavucontrol|foliate|ghostty|nemo|firefox)$",
    },
    opacity = window_opacity .. " override " .. window_opacity .. " override 1.0 override",
})

hl.window_rule({ name = "float-pavu", match = { class = "^(pavucontrol)$" }, float = true })
hl.window_rule({ name = "float-nm", match = { class = "^(nm-connection-editor)$" }, float = true })
hl.window_rule({ name = "float-blueman", match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ name = "float-open", match = { title = "^(Open File)$" }, float = true })
hl.window_rule({ name = "float-save", match = { title = "^(Save File)$" }, float = true })
