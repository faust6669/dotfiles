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
  -- Tab & Window Management
  { key = 'e', mods = 'CTRL', action = act.CloseCurrentTab { confirm = false } },
  { key = 'E', mods = 'CTRL|SHIFT', action = act.SpawnWindow },

  -- WASD Directional Splits (CTRL + SHIFT)
  { key = 'W', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Up', size = { Percent = 50 } } },
  { key = 'S', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Down', size = { Percent = 50 } } },
  { key = 'A', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Left', size = { Percent = 50 } } },
  { key = 'D', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Right', size = { Percent = 50 } } },

  -- WASD Navigation (CTRL only)
  { key = 'w', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 's', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'a', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'd', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },

  -- Tile Management
  { key = 'f', mods = 'CTRL', action = act.CloseCurrentPane { confirm = false } }, -- Close Tile
  { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState },               -- Fullscreen Tile
}

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- FINAL RETURN
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
return config
