local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Dracula'
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 11.0
config.window_background_opacity = 0.9
config.window_decorations = 'RESIZE'
config.window_padding = { left = 12, right = 12, top = 10, bottom = 10 }
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'

config.keys = {
    { key = 'E', mods = 'CTRL', action = wezterm.action.CloseCurrentTab { confirm = true },
    { key = 'W', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Up', size = { Percent = 50 } } },
    { key = 'A', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Left', size = { Percent = 50 } } },
    { key = 'S', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Down', size = { Percent = 50 } } },
    { key = 'D', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Right', size = { Percent = 50 } } },
    { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
    { key = 'e', mods = 'ALT', action = act.SplitPane { direction = 'Right', size = { Percent = 30 }, command = { args = { 'yazi' } } } },
    { key = 'r', mods = 'ALT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    { key = 't', mods = 'ALT', action = act.SpawnTab 'DefaultDomain' },
    { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState },
    { key = 'R', mods = 'ALT|SHIFT', action = act.ReloadConfiguration },
}

return config
