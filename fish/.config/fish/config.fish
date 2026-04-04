# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CACHYOS & BASIC DEFAULTS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Raise file descriptor limit for performance (CachyOS/Wine/VST stability)
ulimit -n 524288

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
abbr -a tt --position anywhere "~"               # Your "Tilde" shortcut
abbr -a dots  'dots'                             # Runs your GitHub sync function
abbr -a gs    'git status'                       # Quick git check
abbr -a bench 'cd ~/dotfiles/scripts'            # Quick jump to your tools
abbr -a conf  'nano ~/.config/fish/config.fish'  # Edit this file fast

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# FUNCTIONS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function dots
    # 1. Define our paths
    set -l dotdir "$HOME/dotfiles"
    set -l target "$dotdir/CHEAT_SHEET.md"

    # 2. Refresh the Symlinks
    # Using --restow ensures any new files in your subfolders get linked
    echo "🔗 Refreshing symlinks with Stow..."
    pushd $dotdir
    stow --restow */
    popd

    # 3. Update Timestamp in Cheat Sheet
    if test -f "$target"
        set -l current_date (date "+%Y-%m-%d %H:%M:%S")
        # Use | as a delimiter to prevent conflicts with date formatting
        sed -i "s|Last Updated: .*|Last Updated: $current_date|" "$target"
        echo "📝 Timestamp updated in CHEAT_SHEET.md"
    end

    # 4. Git Operations
    echo "📦 Staging changes in $dotdir..."
    git -C $dotdir add .

    # Check if there are actually changes to commit
    if git -C $dotdir diff --staged --quiet
        echo "✨ No changes to commit. Everything is up to date!"
    else
        echo "📝 Commit message (Enter for default):"
        read -l msg

        if test -z "$msg"
            set -l d (date '+%Y-%m-%d')
            set msg "Manual dotfile sync on $d"
        end

        echo "🚀 Pushing to GitHub (main)..."
        git -C $dotdir commit -m "$msg"

        # FIXED: Changed master to main to match your GitHub repo
        git -C $dotdir push origin main

        echo "✅ System synced and GitHub updated!"
    end
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# STARSHIP PROMPT (Keep at the end)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
starship init fish | source

# Force cursor to a blinking underline on every new prompt
function reset_cursor_to_blink_underline --on-event fish_prompt
    echo -ne "\e[3 q"
end


