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
alias yz="yazi"

# Terminal Resizing Abbreviations
abbr -a rsz_tall  "printf '\e[8;60;120t'"
abbr -a rsz_wide  "printf '\e[8;40;160t'"
abbr -a rsz_reset "printf '\e[8;35;120t'"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MY CUSTOM ABBREVIATIONS (Hard-Coded for Portability)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
abbr -a tt --position anywhere "~"               # Your "Tilde" shortcut
abbr -a lab 'source ~/env/bench/bin/activate.fish && cd ~/dotfiles/scripts'
abbr -a dots  'dots'                             # Runs your GitHub sync function
abbr -a gs    'git status'                       # Quick git check
abbr -a bench 'cd ~/dotfiles/scripts'            # Quick jump to your tools
abbr -a conf  'nano ~/.config/fish/config.fish'  # Edit this file fast
abbr -a fresh 'source ~/.config/fish/config.fish; echo "🔄 Fish configuration reloaded!"' # refresh terminal

# Modern LS replacement (lsd)
if type -q lsd
    abbr -a ls 'lsd --icon always --group-dirs first'
    abbr -a ll 'lsd -l --icon always --group-dirs first'
    abbr -a la 'lsd -la --icon always --group-dirs first'
    abbr -a tree 'lsd --tree --icon always'
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# FUNCTIONS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function dots
    # 1. Define our paths
    set -l dotdir "$HOME/dotfiles"
    set -l target "$dotdir/CHEAT_SHEET.md"

    # 2. Refresh the Symlinks
    echo "🔗 Refreshing symlinks with Stow..."
    pushd $dotdir
    stow --restow */
    popd

    # 3. Update Timestamp in Cheat Sheet
    if test -f "$target"
        set -l current_date (date "+%Y-%m-%d %H:%M:%S")
        sed -i "s|Last Updated: .*|Last Updated: $current_date|" "$target"
        echo "📝 Timestamp updated in CHEAT_SHEET.md"
    end

    # 4. Git Operations
    # Check if there are any changes (tracked or untracked) BEFORE staging
    if test -n "$(git -C $dotdir status --porcelain)"
        echo "📦 Staging changes in $dotdir..."
        git -C $dotdir add .

        echo "📝 Commit message (Enter for default):"
        read -l msg

        if test -z "$msg"
            set -l d (date '+%Y-%m-%d')
            set msg "Manual dotfile sync on $d"
        end

        echo "🚀 Committing and Pushing to GitHub (main)..."
        git -C $dotdir commit -m "$msg"
        git -C $dotdir push origin main

        echo "✅ System synced and GitHub updated!"
    else
        echo "✨ No changes to commit. Everything is up to date!"
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
