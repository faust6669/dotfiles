
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1. PATH & ENVIRONMENT (MUST BE AT THE TOP)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Ensure system and local binaries are found before starting Starship
fish_add_path /usr/bin
fish_add_path "/home/dave/.local/bin"

# Point Starship to your dotfiles configuration
set -gx STARSHIP_CONFIG ~/dotfiles/starship/.config/starship.toml

# Raise file descriptor limit for performance (CachyOS/Wine/VST stability)
ulimit -n 524288

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. INTERACTIVE SESSION SETUP
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if status is-interactive
    # Display system info
    fastfetch

    # Force thin underline for all modes
    set -g fish_cursor_default underline
    set -g fish_cursor_insert underline
    set -g fish_cursor_replace_one underline
    set -g fish_cursor_visual underline

    # Stop Fish from intercepting Ctrl+E so WezTerm can close panes
    bind -e \ce

    # Initialize Starship Prompt (Safe for interactive only)
    starship init fish | source
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3. ALIASES & ABBREVIATIONS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias dsync='rsync -avP'
alias graph='git log --oneline --graph --decorate --all'
alias fix-audio='systemctl --user restart pipewire pipewire-pulse wireplumber'
alias vst-win='cd "/mnt/windows/Program Files/Common Files/VST3/"'
alias yz="yazi"

# Terminal Resizing Abbreviations
abbr -a rsz_tall  "printf '\e[;;t'"
abbr -a rsz_wide  "printf '\e[;;t'"
abbr -a rsz_reset "printf '\e[;;t'"

# Custom Shortcuts
abbr -a tt --position anywhere "~"
abbr -a lab 'source ~/env/bench/bin/activatefish && cd ~/dotfiles/scripts'
abbr -a dots 'dots'
abbr -a gs 'git status'
abbr -a bench 'cd ~/dotfiles/scripts'
abbr -a conf 'kate ~/config/fish/configfish' # Updated to use Kate
abbr -a fresh  source ~/config/fish/config.fish; echo "🔄 Fish configuration reloaded!"'

# Modern LS replacement (lsd)
if type -q lsd
    abbr -a ls 'lsd --icon always --group-dirs first'
    abbr -a ll 'lsd -l --icon always --group-dirs first'
    abbr -a la 'lsd -la --icon always --group-dirs first'
    abbr -a tree 'lsd --tree --icon always'
end

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  FUNCTIONS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function dots
    set -l dotdir "$HOME/dotfiles"
    set -l target "$dotdir/CHEAT_SHEETmd"

    echo "🔗 Refreshing symlinks with Stow..."
    pushd $dotdir
    stow --restow */
    popd

    if test -f "$target"
        set -l current_date (date "+%Y-%m-%d %H:%M:%S")
        sed -i "s|Last Updated: *|Last Updated: $current_date|" "$target"
        echo "📝 Timestamp updated in CHEAT_SHEETmd"
    end

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
        echo "✨ No changes to commit Everything is up to date!"
    end
end

# Force cursor to a blinking underline on every new prompt
function reset_cursor_to_blink_underline --on-event fish_prompt
    echo -ne "\e[ q"
end

