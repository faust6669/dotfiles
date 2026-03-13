#!/bin/bash

# Navigate to script directory
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$DOTFILES_DIR"

echo "🚀 Starting CachyOS Dotfiles Installation..."

# 1. Install dependencies (CachyOS uses paru/pacman)
sudo pacman -S --needed stow fish wezterm hyprland

# 2. Define your packages
packages=("wezterm" "fish" "hypr")

# 3. The "CachyOS Fix": Remove/Backup existing folders so Stow can link
for package in "${packages[@]}"; do
    if [ -d "$HOME/.config/$package" ] && [ ! -L "$HOME/.config/$package" ]; then
        echo "⚠️  Found existing config for $package. Backing up..."
        mv "$HOME/.config/$package" "$HOME/.config/${package}.bak"
    fi
done

# 4. Perform the Stowing
for package in "${packages[@]}"; do
    echo "🔗 Linking $package..."
    # -R (Restow) is great for updating links
    # -t ~ (Target) explicitly tells it to go to your home folder
    stow -R -v -t "$HOME" "$package"
done
