#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CACHYOS & BASIC DEFAULTS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if status is-interactive
    # Standard CachyOS / Interactive shell setup
    fastfetch
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CURSOR & KEYBINDING TWEAKS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Force thin underline for all modes
set -g fish_cursor_default underline
set -g fish_cursor_insert underline
set -g fish_cursor_replace_one underline
set -g fish_cursor_visual underline

# Stop Fish from intercepting Ctrl+E so WezTerm can close panes
bind -e \ce

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ALIASES
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias dsync='rsync -avP'
alias graph='git log --oneline --graph --decorate --all'
alias fix-audio='systemctl --user restart pipewire pipewire-pulse wireplumber'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# THE DOTS SYNC FUNCTION
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function dots
    set -l target "$HOME/dotfiles/CHEAT_SHEET.md"

    # Update Timestamp in Cheat Sheet
    if test -f "$target"
        set -l current_date (date "+%Y-%m-%d %H:%M:%S")
        sed -i "s/Last Updated: .*/Last Updated: $current_date/" "$target"
    end

    # Stage changes in the dotfiles repo
    git -C ~/dotfiles add .

    # Prompt for message
    echo "📝 Commit message (Enter for default):"
    read -l msg

    if test -z "$msg"
        set msg "Manual dotfile sync on $(date '+%Y-%m-%d')"
    end

    # Push to master
    git -C ~/dotfiles commit -m "$msg"
    git -C ~/dotfiles push origin master

    echo "🚀 GitHub updated and Cheat Sheet timestamped!"
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STARSHIP PROMPT (Keep at the end)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
starship init fish | source

