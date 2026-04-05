
function restore --description 'Restow dotfiles and reload fish config'
    # Navigate to dotfiles to ensure stow runs correctly
    set -l current_dir (pwd)
    cd ~/dotfiles

    # Restow (The -R flag stands for Restow: it un-stows and re-stows in one go)
    stow -R fish
    stow -R wezterm
    stow -R starship

    # Reload the shell config
    source ~/.config/fish/config.fish

    # Return to where you were
    cd $current_dir

    echo "Config restored via GNU Stow."
end
