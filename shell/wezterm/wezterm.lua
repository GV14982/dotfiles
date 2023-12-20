-- Pull in the wezterm API
local wezterm = require 'wezterm'
local action = wezterm.action
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- config.default_prog = { "nu" }

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Frappe'

config.window_background_opacity = 0.9
config.macos_window_background_blur = 50
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- Disable tab and window bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 9999
config.window_decorations = "RESIZE"

-- Setup font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 16

-- Keybinds
config.disable_default_key_bindings = true
config.leader = { key = " ", mods = "CTRL" }

config.keys = {
  {
    key = "P",
    mods = "CTRL",
    action = action.ActivateCommandPalette,
  },
  {
    key = "c",
    mods = "CMD",
    action = action.CopyTo "Clipboard"
  },
  {
    key = "v",
    mods = "CMD",
    action = action.PasteFrom "Clipboard"
  }
}

-- and finally, return the configuration to wezterm
return config
