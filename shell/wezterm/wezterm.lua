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

-- Disable tab and window bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 9999
config.window_decorations = "RESIZE"

-- Setup font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 16
config.adjust_window_size_when_changing_font_size = false

-- Keybinds
config.disable_default_key_bindings = true
-- This leader key functions like the leader key in modal editors like vim
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
    mods = "LEADER",
    action = action.IncreaseFontSize
  },
  {
    key = "-",
    mods = "LEADER",
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
  {
    key = "p",
    mods = "LEADER",
    action = action.ActivateKeyTable { name = "pane" }
  },
  {
    key = "t",
    mods = "LEADER",
    action = action.ActivateKeyTable { name = "tab" }
  },
}

config.key_tables = {
  pane = {
    {
      key = "c",
      action = action.ActivateKeyTable { name = "pane_create" }
    },
    {
      key = "r",
      action = action.ActivateKeyTable { name = "pane_resize", one_shot = false }
    },
    {
      key = "m",
      action = action.ActivateKeyTable { name = "pane_move", one_shot = false }
    },
    {
      key = "x",
      action = action.CloseCurrentPane { confirm = false }
    },
    {
      key = "Escape",
      action = action.PopKeyTable,
    }
  },
  pane_resize = {
    {
      key = "h",
      action = action.AdjustPaneSize { "Left", 1 },
    },
    {
      key = "j",
      action = action.AdjustPaneSize { "Down", 1 },
    },
    {
      key = "k",
      action = action.AdjustPaneSize { "Up", 1 },
    },
    {
      key = "l",
      action = action.AdjustPaneSize { "Right", 1 },
    },
    {
      key = "Escape",
      action = action.PopKeyTable,
    }
  },
  pane_create = {
    {
      key = "h",
      action = action.SplitPane { direction = "Left" },
    },
    {
      key = "j",
      action = action.SplitPane { direction = "Down" },
    },
    {
      key = "k",
      action = action.SplitPane { direction = "Up" },
    },
    {
      key = "l",
      action = action.SplitPane { direction = "Right" },
    },
  },
  pane_move = {
    {
      key = "s",
      action = action.PaneSelect {
        mode = "SwapWithActive",
        alphabet = "123456789"
      }
    },
    {
      key = "<",
      action = action.RotatePanes "CounterClockwise",
    },
    {
      key = ">",
      action = action.RotatePanes "Clockwise",
    },
    {
      key = "Escape",
      action = action.PopKeyTable,
    }
  },
  tab = {
    {
      key = "c",
      action = action.SpawnTab "CurrentPaneDomain"
    },
    {
      key = "x",
      action = action.CloseCurrentTab { confirm = false }
    },
    {
      key = "h",
      action = action.ActivateTabRelative(-1),
    },
    {
      key = "l",
      action = action.ActivateTabRelative(1),
    },
    {
      key = "H",
      action = action.MoveTabRelative(-1),
    },
    {
      key = "L",
      action = action.MoveTabRelative(1),
    },
    {
      key = "n",
      action = action.ShowTabNavigator,
    },
    {
      key = "Escape",
      action = action.PopKeyTable,
    }
  },
}

wezterm.on('update-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_left_status(name or '')
end)
-- and finally, return the configuration to wezterm
return config
