local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('JetBrains Mono')

-- Cursor Settings (Fixed keywords)
config.default_cursor_style = 'SteadyUnderline'
config.cursor_thickness = '1pt'

return config
