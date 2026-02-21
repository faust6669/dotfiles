#!/bin/bash

# Get the directory where this script is located
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

echo "Starting CachyOS Dotfiles Installation..."

# 1. Ensure GNU Stow is installed
if ! command -v stow &> /dev/null; then
    echo "Stow not found. Installing..."
    sudo pacman -S --needed stow
fi

# 2. List the packages you want to stow
# Match these names to your folder names in ~/dotfiles
packages=(
    "wezterm"
    "fish"
    "hypr"
)

# 3. Loop through and stow
for package in "${packages[@]}"; do
    echo "Linking $package..."
    # --adopt is key: it merges existing configs into your dotfiles
    stow -v --adopt "$package"
done

echo "Done! Your configs are now managed in $DOTFILES_DIR"
