#!/usr/bin/env bash
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Function to safely link files
sync_link() {
    local src=$1
    local dst=$2
    mkdir -p "$(dirname "$dst")"
    
    # Only link if the source actually exists
    if [ -f "$src" ] || [ -d "$src" ]; then
        ln -sfn "$src" "$dst"
        echo "✅ Linked $dst"
    else
        echo "❌ Error: $src not found!"
    fi
}

# Now the paths are clean and logical:
sync_link "$DOTFILES_DIR/wezterm/wezterm.lua" "$CONFIG_DIR/wezterm/wezterm.lua"
sync_link "$DOTFILES_DIR/fish/config.fish"     "$CONFIG_DIR/fish/config.fish"
sync_link "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
sync_link "$DOTFILES_DIR/fastfetch.jsonc"      "$CONFIG_DIR/fastfetch/config.jsonc"
