#!/usr/bin/env bash

# Colors for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Starting CachyOS Dotfile Symlinking & Desktop Setup...${NC}"

# Define the source (repo) and target (config)
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Create .config if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Function to safely symlink
link_file() {
    local src=$1
    local dst=$2

    if [ ! -e "$src" ]; then
        echo -e "${RED}❌ Source missing:${NC} $src"
        return
    fi

    # Remove existing file or symlink to prevent "folder inside folder" errors
    rm -rf "$dst"

    # Create the parent directory for the destination
    mkdir -p "$(dirname "$dst")"

    # Create the link
    ln -s "$src" "$dst"
    echo -e "${GREEN}✅ Linked:${NC} $dst -> $src"
}

# --- 1. FISH SETUP ---
echo -e "${BLUE}Setting up Fish...${NC}"
link_file "$DOTFILES_DIR/fish/.config/fish/config.fish"      "$CONFIG_DIR/fish/config.fish"
link_file "$DOTFILES_DIR/fish/.config/fish/fish_variables"   "$CONFIG_DIR/fish/fish_variables"
link_file "$DOTFILES_DIR/fish/.config/fish/conf.d"           "$CONFIG_DIR/fish/conf.d"
link_file "$DOTFILES_DIR/fish/.config/fish/functions"        "$CONFIG_DIR/fish/functions"
link_file "$DOTFILES_DIR/fish/.config/fish/functions/cheat.fish" "$CONFIG_DIR/fish/functions/cheat.fish"

# --- 2. APP CONFIGS ---
echo -e "${BLUE}Setting up Apps...${NC}"
link_file "$DOTFILES_DIR/starship/.config/starship.toml" "$CONFIG_DIR/starship.toml"
link_file "$DOTFILES_DIR/wezterm/.config/wezterm" "$CONFIG_DIR/wezterm"
link_file "$DOTFILES_DIR/yazi/.config/yazi" "$CONFIG_DIR/yazi"
link_file "$DOTFILES_DIR/cava/config" "$CONFIG_DIR/cava/config"
link_file "$DOTFILES_DIR/fastfetch.jsonc" "$CONFIG_DIR/fastfetch/config.jsonc"

# --- 3. KDE PLASMA KEYBOARD SHORTCUTS ---
echo -e "${BLUE}Configuring WezTerm Global Shortcut...${NC}"

# Define your preferred shortcut key combo here
# Note: Use 'Ctrl+Alt+T' or 'Ctrl+Shift+E' exactly as formatted below
SHORTCUT_KEY="Ctrl+Alt+T"

if command -v kwriteconfig6 &> /dev/null; then
    # Write the shortcut key binding directly to KDE's global shortcut configuration
    kwriteconfig6 --file kglobalshortcutsrc --group "org.erikreider.ananke" --key "launch-wezterm" "$SHORTCUT_KEY,none,Launch WezTerm"

    # Safely reload the KDE global shortcut daemon to apply changes instantly without logging out
    dbus-send --print-reply --dest=org.kde.kglobalaccel /component/org_erikreider_ananke org.kde.kglobalaccel.Component.reloadSettings &> /dev/null

    echo -e "${GREEN}✅ Shortcut set:${NC} Press $SHORTCUT_KEY to launch WezTerm."
else
    echo -e "${RED}⚠️  KDE Configuration tools not found. Skipping shortcut mapping.${NC}"
fi

echo -e "\n${BLUE}⭐ All set! Restart your terminal or use your new hotkey to roll.${NC}"
