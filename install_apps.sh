#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -e

echo "====== Starting System Provisioning ======"

# 1. Update Core System Repositories
echo "--> Updating system package databases..."
sudo pacman -Syu --noconfirm

# 2. Define Core Pacman Packages (Native Arch/CachyOS)
# Add or remove package names from this list as needed
PACMAN_PKGS=(
    "eza"                   # Modern ls replacement
    "lsd"                   # Icon-rich ls alternative
    "broot"                 # Interactive directory navigation
    "ttf-nerd-fonts-symbols"# Required for terminal icons
    "git"                   # Version control
    "neovim"                # Text editing
    "tmux"                  # Terminal multiplexer
    "fastfetch"             # System information display
    "stow"                  # Symlink manager (great for dotfiles!)
)

echo "--> Installing native Pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

# 3. Define and Install AUR Packages via Yay (CachyOS default helper)
# Add your favorite AUR/LazyGit utilities here
AUR_PKGS=(
    "lazygit"               # Terminal UI for git
    "visual-studio-code-bin"# Example AUR application
)

if command -v yay &> /dev/null; then
    echo "--> Installing AUR packages via yay..."
    yay -S --needed --noconfirm "${AUR_PKGS[@]}"
else
    echo "--> Warning: 'yay' package helper not found. Skipping AUR packages."
fi

echo "====== Installation Complete! ======"
