#!/usr/bin/fish

# Define Paths
set -l DOTFILES_DIR $HOME/dotfiles
set -l TARGET_DIR $HOME/.config

# 1. FORCE STARSHIP (Name visible, No Blocks)
set -Ux STARSHIP_CONFIG $TARGET_DIR/starship.toml
rm -rf $TARGET_DIR/starship.toml
echo 'format = "$username$hostname$directory$git_branch$character"
[username]
show_always = true
style_user = "bold blue"
format = "[$user]($style) "
[hostname]
ssh_only = false
format = "@[$hostname](bold magenta) "
[directory]
style = "bold cyan"
[character]
success_symbol = "➜ "
error_symbol = "➜ "' > $DOTFILES_DIR/starship/.config/starship.toml

# 2. FORCE WEZTERM (Borderless, Ctrl+E shortcuts)
rm -rf $TARGET_DIR/wezterm
mkdir -p $TARGET_DIR/wezterm
echo "local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('JetBrains Mono')
config.window_decorations = 'NONE'
config.enable_tab_bar = false
config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }
config.keys = {
  { key = 'e', mods = 'CTRL', action = act.CloseCurrentTab { confirm = false } },
  { key = 'E', mods = 'CTRL|SHIFT', action = act.SpawnWindow },
}
return config" > $DOTFILES_DIR/wezterm/.config/wezterm/wezterm.lua

# 3. LINK EVERYTHING
ln -sf $DOTFILES_DIR/starship/.config/starship.toml $TARGET_DIR/starship.toml
ln -sf $DOTFILES_DIR/wezterm/.config/wezterm/wezterm.lua $TARGET_DIR/wezterm/wezterm.lua

echo 'Settings locked and replaced!' 
