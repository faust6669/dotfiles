#!/usr/bin/env bash

# Colors for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Starting CachyOS Automation Deployment...${NC}"

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
PKG_FILE="$DOTFILES_DIR/packages.txt"

# --- 0. AUTOMATED PACKAGE INSTALLATION ---
if [ -f "$PKG_FILE" ]; then
    echo -e "${BLUE}📦 Reading package list from $PKG_FILE...${NC}"

    # Extract packages, ignoring comments, trailing comments, and empty lines
    pkgs=$(grep -v '^#' "$PKG_FILE" | sed 's/#.*//' | awk '{print $1}')

    # Separate native pacman packages vs AUR packages
    pacman_pkgs=""
    aur_pkgs=""

    # Determine default AUR helper on CachyOS
    AUR_HELPER="paru"
    if ! command -v paru &> /dev/null; then
        AUR_HELPER="yay"
    fi

    for pkg in $pkgs; do
        # If package ends in -bin or -git, or if pacman can't find it natively, flag as AUR
        if [[ "$pkg" == *"-bin"* || "$pkg" == *"-git"* ]] || ! pacman -Si "$pkg" &> /dev/null; then
            aur_pkgs="$aur_pkgs $pkg"
        else
            pacman_pkgs="$pacman_pkgs $pkg"
        fi
    done

    # Install official repo packages
    if [ -n "$pacman_pkgs" ]; then
        echo -e "${BLUE}System: Installing official repository packages...${NC}"
        sudo pacman -S --needed --noconfirm $pacman_pkgs
    fi

    # Install AUR packages
    if [ -n "$aur_pkgs" ]; then
        echo -e "${BLUE}AUR: Installing specialized packages via $AUR_HELPER...${NC}"
        $AUR_HELPER -S --needed --noconfirm $aur_pkgs
    fi
else
    echo -e "${RED}⚠️  packages.txt not found at $PKG_FILE. Skipping app installation.${NC}"
fi

# --- 1. FISH SETUP ---
echo -e "${BLUE}Setting up Fish...${NC}"
mkdir -p "$CONFIG_DIR"

link_file() {
    local src=$1
    local dst=$2
    if [ ! -e "$src" ]; then
        echo -e "${RED}❌ Source missing:${NC} $src"
        return
    fi
    rm -rf "$dst"
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo -e "${GREEN}✅ Linked:${NC} $dst -> $src"
}

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
SHORTCUT_KEY="Ctrl+Alt+T"
if command -v kwriteconfig6 &> /dev/null; then
    kwriteconfig6 --file kglobalshortcutsrc --group "org.erikreider.ananke" --key "launch-wezterm" "$SHORTCUT_KEY,none,Launch WezTerm"
    dbus-send --print-reply --dest=org.kde.kglobalaccel /component/org_erikreider_ananke org.kde.kglobalaccel.Component.reloadSettings &> /dev/null
    echo -e "${GREEN}✅ Shortcut set:${NC} Press $SHORTCUT_KEY to launch WezTerm."
fi

echo -e "\n${BLUE}⭐ All set! System packages installed and configs deployed.${NC}"
