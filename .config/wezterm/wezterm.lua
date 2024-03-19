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

-- Disable tab and window bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 9999
config.window_decorations = "RESIZE"

-- Setup font
config.font = wezterm.font("Hack Nerd Font", { weight = "DemiBold" })
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
    key = "w",
    mods = "LEADER",
    action = action.ActivateKeyTable { name = "win" }
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
  {
    key = "s",
    mods = "LEADER",
    action = action.ActivateKeyTable { name = "scroll", one_shot = false }
  },
  {
    key = "/",
    mods = "LEADER",
    action = action.Search { CaseInSensitiveString = "" }
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
      action = action.ClearKeyTableStack,
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
      action = action.ClearKeyTableStack,
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
      action = action.ClearKeyTableStack,
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
      key = "r",
      action = action.PromptInputLine({
        description = "Tab Name?",
        action = wezterm.action_callback(function(window, _, line)
          if line then
            window:active_tab():set_title(line)
          end
        end)
      })
    },
    {
      key = "Escape",
      action = action.ClearKeyTableStack,
    }
  },
  win = {
    {
      key = "h",
      action = action.EmitEvent "notif"
    },
    {
      key = "c",
      action = action.PromptInputLine {
        description = "Enter name for workspace",
        action = wezterm.action_callback(function(window, pane, name)
          window:perform_action(
            window:perform_action(
              action.SwitchToWorkspace {
                name = name,
                spawn = {
                  cwd = pane:get_current_working_dir()
                }
              }
            ),
            pane
          )
        end)
      }
    },
    {
      key = "s",
      action = action.ShowLauncherArgs {
        flags = "FUZZY|WORKSPACES"
      }
    },
    {
      key = "Escape",
      action = action.ClearKeyTableStack,
    }
  },
  scroll = {
    {
      key = "j",
      action = action.ScrollByLine(1)
    },
    {
      key = "k",
      action = action.ScrollByLine(-1)
    },
    {
      key = "d",
      mods = "CTRL",
      action = action.ScrollByPage(0.5)
    },
    {
      key = "u",
      mods = "CTRL",
      action = action.ScrollByPage(-0.5)
    },
    {
      key = "f",
      mods = "CTRL",
      action = action.ScrollByPage(1)
    },
    {
      key = "b",
      mods = "CTRL",
      action = action.ScrollByPage(-1)
    },
    {
      key = "G",
      action = action.ScrollToBottom
    },
    {
      key = "g",
      action = action.ActivateKeyTable { name = "g" }
    },
    {
      key = "Escape",
      action = action.ClearKeyTableStack,
    },
    {
      key = "c",
      action = action.ActivateCopyMode
    }
  },
  g = {
    {
      key = "g",
      action = action.ScrollToTop
    },
    {
      key = "Escape",
      action = action.ClearKeyTableStack,
    }
  },
}

for i = 1, 10, 1 do
  config.key_tables.tab[#config.key_tables.tab + 1] = {
    key = tostring(i % 10),
    action = action.ActivateTab(i - 1)
  }
end

wezterm.on('update-status', function(window)
  local name = window:active_key_table()
  if name then
    name = name
  end
  local status = " " .. (name or "default") .. " "
  window:set_left_status(status)
end)


-- and finally, return the configuration to wezterm
return config
