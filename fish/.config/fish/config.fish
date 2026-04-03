
ulimit -n 524288
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
# ALIASES & ABBREVIATIONS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias dsync='rsync -avP'
alias graph='git log --oneline --graph --decorate --all'
alias fix-audio='systemctl --user restart pipewire pipewire-pulse wireplumber'
alias vst-win='cd "/mnt/windows/Program Files/Common Files/VST3/"'

# Terminal Resizing Abbreviations
abbr -a rsz_tall  "printf '\e[8;60;120t'"
abbr -a rsz_wide  "printf '\e[8;40;160t'"
abbr -a rsz_reset "printf '\e[8;35;120t'"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MY CUSTOM ABBREVIATIONS (Hard-Coded for Portability)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
abbr -a tt --position anywhere "~"                        # Your "Tilde" shortcut
abbr -a dots  'dots'                   # Runs your GitHub sync function
abbr -a gs    'git status'             # Quick git check
abbr -a bench 'cd ~/dotfiles/scripts'  # Quick jump to your Python tools
abbr -a conf  'nano ~/.config/fish/config.fish' # Edit this file fast



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# FUNCTIONS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# The Dots Sync Function
function dots
    set -l dotdir "$HOME/dotfiles"
    set -l target "$dotdir/CHEAT_SHEET.md"

    # 1. THE STOW STEP (The missing piece)
    # This ensures everything in your dotfiles folder is properly
    # symlinked to your Home directory before you push.
    echo "🔗 Refreshing symlinks with Stow..."
    # We use 'pushd' to jump into the directory and 'popd' to jump back
    pushd $dotdir
    # This stows every top-level folder (fish, wezterm, etc.)
    stow * popd

    # 2. Update Timestamp in Cheat Sheet
    if test -f "$target"
        set -l current_date (date "+%Y-%m-%d %H:%M:%S")
        sed -i "s/Last Updated: .*/Last Updated: $current_date/" "$target"
    end

    # 3. Stage changes
    git -C $dotdir add .

    # 4. Prompt for message
    echo "📝 Commit message (Enter for default):"
    read -l msg

    if test -z "$msg"
        set msg "Manual dotfile sync on $(date '+%Y-%m-%d')"
    end

    # 5. Push to master
    git -C $dotdir commit -m "$msg"
    git -C $dotdir push origin master

    echo "🚀 System linked, GitHub updated, and Cheat Sheet timestamped!"
end


# Dynamic Resize Function (Usage: rsz rows cols)
function rsz
    if test (count $argv) -eq 2
        printf "\e[8;$argv[1];$argv[2]t"
    else
        echo "Usage: rsz [rows] [cols]"
    end
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STARSHIP PROMPT (Keep at the end)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
starship init fish | source
ulimit -n 524288
