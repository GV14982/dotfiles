-- Pull in the wezterm API
local wezterm = require "wezterm"
local action = wezterm.action
local mux = wezterm.mux
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Set out shell env var so Wezterm will start fish instead of zsh
config.set_environment_variables = {
  SHELL = "/opt/homebrew/bin/fish"
}

-- Set theme to Catppuccin Frappe
config.color_scheme = "Catppuccin Frappe"

-- Add some padding inside the window
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.window_background_opacity = 0.75
config.macos_window_background_blur = 30
-- config.front_end = "WebGpu"
-- Disable tab and window bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 9999
config.window_decorations = "RESIZE"

-- Setup font
config.font = wezterm.font("FiraCode Nerd Font", { weight = "DemiBold" })
config.font_size = 16
config.adjust_window_size_when_changing_font_size = false

-- Keybinds
config.disable_default_key_bindings = true
-- This leader key functions like the leader key in modal editors like vim
config.keys = {
  {
    key = "P",
    mods = "CTRL",
    action = action.ActivateCommandPalette,
  },
  {
    key = "+",
    mods = "CMD",
    action = action.IncreaseFontSize
  },
  {
    key = "-",
    mods = "CMD",
    action = action.DecreaseFontSize
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
  },
}

-- and finally, return the configuration to wezterm
return config
