-- input.lua
hl.input({
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,
    sensitivity = 1,
    accel_profile = "flat",

    touchpad = {
        natural_scroll = true,
        scroll_factor = 3,
    },
})

hl.gesture(3, "horizontal", "workspace")

hl.device({
    name = "epic-mouse-v1",
    sensitivity = 1,
})
