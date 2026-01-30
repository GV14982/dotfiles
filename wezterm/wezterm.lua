local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16
config.adjust_window_size_when_changing_font_size = false
config.enable_wayland = false
config.color_scheme = "Catppuccin Macchiato"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95
return config
