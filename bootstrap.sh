#!/usr/bin/env bash
# Exit immediately if any command fails
set -e

# ==========================================
# CONFIGURATION - CHANGE THESE TO YOUR OWN!
# ==========================================
DOTFILES_REPO="https://github.com"
DOTFILES_DIR="$HOME/dotfiles"

echo "====== Starting Full System Bootstrap ======"

# 1. Update Core System
echo "--> Updating package databases..."
sudo pacman -Syu --noconfirm

# 2. Define Core Packages (Including Fish and Stow)
PACMAN_PKGS=(
    "git"                   # Required to clone your repo
    "stow"                  # Required to symlink config folders
    "fish"                  # Your preferred shell
    "eza"                   # Modern ls replacement
    "lsd"                   # Icon-rich ls alternative
    "broot"                 # Interactive directory navigation
    "ttf-nerd-fonts-symbols"# Required for terminal icons
    "neovim"                # Text editing
    "tmux"                  # Terminal multiplexer
    "fastfetch"             # System information display
)

echo "--> Installing native Pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"

# 3. Install AUR Packages via Yay (CachyOS default helper)
AUR_PKGS=(
    "lazygit"
)

if command -v yay &> /dev/null; then
    echo "--> Installing AUR packages via yay..."
    yay -S --needed --noconfirm "${AUR_PKGS[@]}"
else
    echo "--> Warning: 'yay' helper not found. Skipping AUR packages."
fi

# 4. Clone Your Dotfiles Repository
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "--> Cloning dotfiles repository to $DOTFILES_DIR..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    echo "--> Dotfiles directory already exists at $DOTFILES_DIR. Skipping clone."
fi

# 5. Automatically Symlink Configurations with GNU Stow
echo "--> Symlinking configurations via GNU Stow..."
cd "$DOTFILES_DIR"

for dir in */; do
    dir_name=$(basename "$dir")
    echo "    Linking component: $dir_name"
    # --adopt forces stow to link even if a default config already exists
    stow --adopt "$dir_name"
done

# Reset any accidental changes made to the repo files by the --adopt flag
git reset --hard HEAD

# 6. Set Fish as Default Shell
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "fish" ]; then
    echo "--> Setting Fish as your default shell..."
    # Ensure fish is registered in /etc/shells
    if ! grep -Fxq "$(which fish)" /etc/shells; then
        echo "$(which fish)" | sudo tee -a /etc/shells
    fi
    chsh -s "$(which fish)"
else
    echo "--> Fish is already your default shell."
fi

echo "====== System Bootstrap Complete! ======"
echo "Please log out and log back in (or restart your terminal) to enter your Fish environment."

# 7. Bootstrap Fisher and Fish Plugins
echo "--> Bootstrapping Fisher plugin manager..."
fish -c "
    # Install Fisher if it isn't present
    if not functions -q fisher
        curl -sL https://githubusercontent.com | source && fisher install jorgebucaran/fisher
    end

    # Automatically install all plugins listed in your tracked fish_plugins file
    if test -f \$HOME/.config/fish/fish_plugins
        echo '--> Installing Fish plugins from fish_plugins file...'
        fisher update
    end
"
