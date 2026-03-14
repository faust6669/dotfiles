#!/usr/bin/env bash

# Colors for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Starting CachyOS Dotfile Symlinking...${NC}"

# Define the source (repo) and target (config)
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Create .config if it doesn't exist [cite: 28]
mkdir -p "$CONFIG_DIR"

# Function to safely symlink [cite: 28]
link_file() {
    local src=$1
    local dst=$2
    
    if [ ! -e "$src" ]; then
        echo -e "${RED}❌ Source missing:${NC} $src"
        return
    fi

    # Remove existing file or symlink to prevent "folder inside folder" errors [cite: 28]
    rm -rf "$dst"
    
    # Create the parent directory for the destination [cite: 28]
    mkdir -p "$(dirname "$dst")"
    
    # Create the link
    ln -s "$src" "$dst"
    echo -e "${GREEN}✅ Linked:${NC} $dst -> $src"
}

# --- 1. FISH SETUP ---
# Points to the nested .config structure to ensure your "dots" command works [cite: 2, 63]
echo -e "${BLUE}Setting up Fish...${NC}"
link_file "$DOTFILES_DIR/fish/.config/fish/config.fish"      "$CONFIG_DIR/fish/config.fish"
link_file "$DOTFILES_DIR/fish/fish_variables"                "$CONFIG_DIR/fish/fish_variables"
link_file "$DOTFILES_DIR/fish/conf.d"                        "$CONFIG_DIR/fish/conf.d"
link_file "$DOTFILES_DIR/fish/functions"                     "$CONFIG_DIR/fish/functions"
# Specifically link the cheat command function [cite: 3, 66]
link_file "$DOTFILES_DIR/fish/.config/fish/functions/cheat.fish" "$CONFIG_DIR/fish/functions/cheat.fish"

# --- 2. APP CONFIGS ---
echo -e "${BLUE}Setting up Apps...${NC}"

# Starship: Point to the nested .config file [cite: 3]
link_file "$DOTFILES_DIR/starship/.config/starship.toml" "$CONFIG_DIR/starship.toml"

# WezTerm: Link the internal config directory 
link_file "$DOTFILES_DIR/wezterm/.config/wezterm" "$CONFIG_DIR/wezterm"

# Yazi: Link the internal config directory 
link_file "$DOTFILES_DIR/yazi/.config/yazi" "$CONFIG_DIR/yazi"

# Cava: Link the specific config file [cite: 1]
link_file "$DOTFILES_DIR/cava/config" "$CONFIG_DIR/cava/config"

# Fastfetch: Link the jsonc file to the expected config path [cite: 30]
link_file "$DOTFILES_DIR/fastfetch.jsonc" "$CONFIG_DIR/fastfetch/config.jsonc"

echo -e "\n${BLUE}⭐ All set! Restart your terminal to apply changes.${NC}"
