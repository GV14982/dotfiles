-- Pull in the wezterm API
local wezterm = require "wezterm"
local action = wezterm.action
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.set_environment_variables = {
  SHELL = "/opt/homebrew/bin/fish"
}

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Frappe"

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
config.adjust_window_size_when_changing_font_size = false

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
    key = "|",
    mods = "LEADER",
    action = action.SplitHorizontal { domain = "CurrentPaneDomain" }
  },
  {
    key = "_",
    mods = "LEADER",
    action = action.SplitVertical { domain = "CurrentPaneDomain" }
  },
  {
    key = "t",
    mods = "LEADER",
    action = action.SpawnTab "CurrentPaneDomain"
  },
  {
    key = "p",
    mods = "LEADER",
    action = action.SpawnWindow
  },
  {
    key = "c",
    mods = "LEADER",
    action = action.CloseCurrentPane { confirm = false }
  },
  {
    key = "x",
    mods = "LEADER",
    action = action.CloseCurrentTab { confirm = false }
  },
  {
    key = "h",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Left",
  },
  {
    key = "j",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Up",
  },
  {
    key = "l",
    mods = "LEADER",
    action = action.ActivatePaneDirection "Right",
  },
}

-- and finally, return the configuration to wezterm
return config
