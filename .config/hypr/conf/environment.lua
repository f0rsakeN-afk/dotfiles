-- environment.lua
hl.env({
    "XCURSOR_SIZE=24",
    "HYPRCURSOR_SIZE=24",
    "GDK_BACKEND=wayland,x11,*",
    "QT_QPA_PLATFORM=wayland;xcb",
    "QT_QPA_PLATFORMTHEME=qt5ct",
    "QT_QPA_PLATFORMTHEME=qt6ct",
    "QT_STYLE_OVERRIDE=kvantum",
    "SDL_VIDEODRIVER=wayland",
    "MOZ_ENABLE_WAYLAND=1",
    "ELECTRON_OZONE_PLATFORM_HINT=wayland",
    "OZONE_PLATFORM=wayland",
})

hl.xwayland({
    force_zero_scaling = true,
})

hl.ecosystem({
    no_update_news = true,
})
