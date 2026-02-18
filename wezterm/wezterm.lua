local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Color Scheme
config.color_scheme = 'Catppuccin Mocha'

-- Font (Make sure ttf-jetbrains-mono-nerd is installed)
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 11.0

-- Transparency & Blur
config.window_background_opacity = 0.85
config.win32_system_backdrop = 'Acrylic'

-- Padding (Gives the 'Time' on the right some breathing room)
config.window_padding = {
  left = 15,
  right = 15,
  top = 15,
  bottom = 10,
}

-- Clean look: No Title Bar, just the window
config.window_decorations = "RESIZE"

return config
