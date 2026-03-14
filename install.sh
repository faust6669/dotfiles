#!/usr/bin/env bash

# Colors for clarity
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Starting CachyOS Dotfile Symlinking...${NC}"

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

mkdir -p "$CONFIG_DIR"

link_file() {
    local src=$1
    local dst=$2
    
    if [ ! -e "$src" ]; then
        echo -e "${RED}❌ Source missing:${NC} $src"
        return
    fi

    # Remove existing file/link to avoid "folder inside folder" errors 
    rm -rf "$dst"
    
    # Ensure the parent directory exists
    mkdir -p "$(dirname "$dst")"
    
    ln -s "$src" "$dst"
    echo -e "${GREEN}✅ Linked:${NC} $dst -> $src"
}

# --- 1. FISH SETUP ---
echo -e "${BLUE}Setting up Fish...${NC}"
# Linking the main config and support folders [cite: 29, 32]
link_file "$DOTFILES_DIR/fish/.config/fish/config.fish" "$CONFIG_DIR/fish/config.fish"
link_file "$DOTFILES_DIR/fish/fish_variables"            "$CONFIG_DIR/fish/fish_variables"
link_file "$DOTFILES_DIR/fish/conf.d"                    "$CONFIG_DIR/fish/conf.d"
link_file "$DOTFILES_DIR/fish/functions"                 "$CONFIG_DIR/fish/functions"

# --- 2. APP CONFIGS ---
echo -e "${BLUE}Setting up Apps...${NC}"

# Starship: Fixed the double-link error 
link_file "$DOTFILES_DIR/starship/.config/starship.toml" "$CONFIG_DIR/starship.toml"

# WezTerm: Linking the whole directory for Lua modules [cite: 30, 72]
link_file "$DOTFILES_DIR/wezterm/.config/wezterm"        "$CONFIG_DIR/wezterm"

# Yazi & Cava 
link_file "$DOTFILES_DIR/yazi/.config/yazi"              "$CONFIG_DIR/yazi"
link_file "$DOTFILES_DIR/cava/config"                    "$CONFIG_DIR/cava/config"

# Fastfetch [cite: 30, 31]
link_file "$DOTFILES_DIR/fastfetch.jsonc"                "$CONFIG_DIR/fastfetch/config.jsonc"

echo -e "\n${BLUE}⭐ All set! Open a new terminal to see the changes.${NC}"

