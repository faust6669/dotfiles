# 1. Distro Defaults (Performance First)
if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# 2. Pathing (Clean & Non-Redundant)
fish_add_path ~/.config/emacs/bin

# 3. Environment & Intel 12th Gen Tweaks
set -gx GAMEMODERUN 1
set -gx NODEVICE_SELECT 1
set -gx STARSHIP_CONFIG ~/.config/starship.toml

# 4. Aliases
alias dsync='~/.emacs.d/bin/doom sync'
alias fastfetch="fastfetch -c ~/.config/fastfetch/config.jsonc --logo arch"
alias graph="qpwgraph -a ~/mystudio.xml &"
alias fix-audio="qpwgraph -a ~/working_setup.xml &; wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%"

# 5. Abbreviations (Interactive Only)
if status is-interactive
    abbr -a tt '~'
    abbr -a --position anywhere tt '~'
    abbr -a update-sys 'sudo pacman -Syu' # Renamed to avoid conflict with update function
    abbr -a --save twin 'ollama run mytwin'
    
    # Initialize Prompt
    starship init fish | source
end

# 6. The "Nuclear" Greeting
function fish_greeting
    if status is-interactive
        command fastfetch -c ~/.config/fastfetch/config.jsonc --logo arch
    end
end

# 7. Dotfile Manager (The Brain)
function dots --description 'Sync dotfiles and update timestamp'
    set -l target ~/dotfiles/CHEAT_SHEET.md
    cd ~/dotfiles

    # Update Cheat Sheet
    if test -f $target
        sed -i "s/^> **Last Synced:**.*/> **Last Synced:** "(date "+%Y-%m-%d %H:%M")"/" $target
    end

    git add .

    echo -n "📝 Commit message (Enter for default): "
    read msg
    if test -z "$msg"
        set msg "Manual Sync: "(date "+%Y-%m-%d %H:%M")
    end

    git commit -m "$msg"
    git push origin master  # Corrected to master based on your environment
    cd -
    echo "🚀 GitHub updated and Cheat Sheet timestamped!"
end

# 8. Global Update
function update
    echo "🚀 Starting System Update..."
    paru -Syu

    echo "📂 Checking Dotfiles..."
    cd ~/dotfiles
    if not git diff --quiet
        echo "✨ Changes detected! Backing up..."
        git add .
        git commit -m "Auto-backup: "(date +'%Y-%m-%d %H:%M')
        git push origin master
    else
        echo "✅ Dotfiles are already up to date."
# 8. Global Update
function update
    echo "🚀 Starting System Update..."
    # Perform system update; only proceed to dotfiles if successful
    if paru -Syu
        echo "📂 Checking Dotfiles..."
        cd ~/dotfiles || return

        # Pull first to ensure we aren't out of sync with GitHub
        git pull origin master --rebase

        if not git diff --quiet
            echo "✨ Changes detected! Backing up..."
            git add .
            git commit -m "Auto-backup: (date +'%Y-%m-%d %H:%M')"
            git push origin master
        else
            echo "✅ Dotfiles are already up to date."
        end
        
        cd - # Return to previous directory
    else
        echo "❌ System update failed. Skipping dotfile backup."
    end
end

