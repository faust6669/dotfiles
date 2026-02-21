
local wezterm = require 'wezterm'
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- APPEARANCE & UI
config.color_scheme = 'Dracula'
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 11.0
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_padding = { left = 12, right = 12, top = 10, bottom = 10 }
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'

config.colors = {
    tab_bar = {
        background = 'rgba(0, 0, 0, 0)',
        active_tab = {
            bg_color = '#44475a',
            fg_color = '#f8f8f2',
        },
    },
}

-- KEY BINDINGS
config.keys = {
    -- WASD DIRECTIONAL SPLITS (Ctrl + Shift + WASD)
    { key = 'W', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Up', size = { Percent = 50 } } },
    { key = 'A', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Left', size = { Percent = 50 } } },
    { key = 'S', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Down', size = { Percent = 50 } } },
    { key = 'D', mods = 'CTRL|SHIFT', action = act.SplitPane { direction = 'Right', size = { Percent = 50 } } },

    -- NAVIGATION (Alt + HJKL)
    { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },

    -- SMART YAZI (Alt + e)
    { key = 'e', mods = 'ALT', action = act.SplitPane {
        direction = 'Right',
        size = { Percent = 30 },
        command = { args = { 'yazi' } }
    } },

    -- RESIZE MODE (Alt + r)
    { key = 'r', mods = 'ALT', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },

    -- TABS & UTILS
    { key = 't', mods = 'ALT', action = act.SpawnTab 'DefaultDomain' },
    { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState },
    { key = 'R', mods = 'ALT|SHIFT', action = act.ReloadConfiguration },

    -- CLOSING PANES
    { key = 'e', mods = 'CTRL', action = act.CloseCurrentPane { confirm = false } },
    { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = false } },
}

-- KEY TABLES (Modes)
config.key_tables = {
    resize_pane = {
        { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
        { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
        { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'Enter', action = 'PopKeyTable' },
    },
}

-- MOUSE BINDINGS
config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = 'Left' } },
        mods = 'SUPER',
        action = act.StartWindowDrag,
    },
}

return config
