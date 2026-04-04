local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- APPEARANCE & UI
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('Firacode Nerd Font Mono')
config.window_decorations = 'NONE'
config.enable_tab_bar = false
config.window_background_opacity = 0.70
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- KEYBINDINGS (config.keys)
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
config.keys = {
  -- Existing Tab & Window Management
  { key = 'e', mods = 'CTRL', action = act.CloseCurrentTab { confirm = false } },
  { key = 'E', mods = 'CTRL|SHIFT', action = act.SpawnWindow },

  -- WASD Directional Splits (CTRL + SHIFT)
  -- 'w' for Up, 's' for Down, 'a' for Left, 'd' for Right
  {
    key = 'W',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane { direction = 'Up', size = { Percent = 50 } }
  },
  {
    key = 'S',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane { direction = 'Down', size = { Percent = 50 } }
  },
  {
    key = 'A',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane { direction = 'Left', size = { Percent = 50 } }
  },
  {
    key = 'D',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane { direction = 'Right', size = { Percent = 50 } }
  },

  -- HJKL Navigation (ALT + Direction)
  -- Used to move your focus between the panes you just created
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

  -- Extra Management
  { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState }, -- Fullscreen a pane
  { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = false } },
}

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- FINAL RETURN
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
return config
