local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('Firacode Nerd Font Mono')
config.window_decorations = 'NONE'
config.enable_tab_bar = false
config.window_background_opacity = 0.70
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }
config.keys = {
  { key = 'e', mods = 'CTRL', action = act.CloseCurrentTab { confirm = false } },
  { key = 'E', mods = 'CTRL|SHIFT', action = act.SpawnWindow },
}
return config
