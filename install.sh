#!/usr/bin/env bash

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

    # Crucial: Remove existing file/link to avoid "folder inside folder" errors
    rm -rf "$dst"
    
    mkdir -p "$(dirname "$dst")"
    
    ln -s "$src" "$dst"
    echo -e "${GREEN}✅ Linked:${NC} $dst -> $src"
}

# --- 1. FISH SETUP ---
echo -e "${BLUE}Setting up Fish...${NC}"
# POINT TO THE REAL FILE: Changed from config.fish.save to config.fish
link_file "$DOTFILES_DIR/fish/config.fish"      "$CONFIG_DIR/fish/config.fish"
link_file "$DOTFILES_DIR/fish/fish_variables"   "$CONFIG_DIR/fish/fish_variables"
link_file "$DOTFILES_DIR/fish/conf.d"           "$CONFIG_DIR/fish/conf.d"
link_file "$DOTFILES_DIR/fish/functions"        "$CONFIG_DIR/fish/functions"

# --- 2. APP CONFIGS ---
echo -e "${BLUE}Setting up Apps...${NC}"

link_file "$DOTFILES_DIR/starship"              "$CONFIG_DIR/starship.toml"
link_file "$DOTFILES_DIR/wezterm"               "$CONFIG_DIR/wezterm"
link_file "$DOTFILES_DIR/yazi"                  "$CONFIG_DIR/yazi"
link_file "$DOTFILES_DIR/cava/config"           "$CONFIG_DIR/cava/config"

# Correcting Fastfetch path to match the standard config location
link_file "$DOTFILES_DIR/fastfetch.jsonc"       "$CONFIG_DIR/fastfetch/config.jsonc"

echo -e "\n${BLUE}⭐ All set! Open a new terminal to see the changes.${NC}"
