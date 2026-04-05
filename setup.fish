
#!/usr/bin/fish

set -l DOTFILES_DIR $HOME/dotfiles

# 1. Ensure the directory structure exists in your home folder
mkdir -p $HOME/.config/wezterm
mkdir -p $HOME/.config/fish

# 2. Let Stow manage the links
# This connects your master files to the live system without changing their content
cd $DOTFILES_DIR
stow -R fish
stow -R wezterm
stow -R starship

echo 'Dotfiles refreshed! Transparency and WASD bindings are active.'
