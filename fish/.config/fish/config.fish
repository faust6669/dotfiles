# 1. Distro Defaults (Performance First)
if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish 
end

# 2. Pathing
fish_add_path ~/.config/emacs/bin 

# 3. Environment & Intel 12th Gen Tweaks
set -gx GAMEMODERUN 1 
set -gx NODEVICE_SELECT 1 
set -gx STARSHIP_CONFIG ~/.config/starship.toml 

# 4. Aliases
alias dsync='~/.emacs.d/bin/doom sync' 
alias fastfetch="fastfetch -c ~/.config/fastfetch/config.jsonc --logo arch" 
alias graph="qpwgraph -a ~/mystudio.xml &" 
alias fix-audio="qpwgraph -a ~/working_setup.xml; and wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%" 

# 5. Abbreviations
if status is-interactive 
    abbr -a tt '~' 
    abbr -a --position anywhere tt '~' 
    abbr -a update-sys 'sudo pacman -Syu' 
    abbr -a --save twin 'ollama run mytwin' 
    
    starship init fish | source 
end

# 6. Greeting
function fish_greeting
    if status is-interactive 
        command fastfetch -c ~/.config/fastfetch/config.jsonc --logo arch 
    end
end

# 7. Dotfile Manager
function dots --description 'Sync dotfiles and update timestamp'
    set -l target ~/dotfiles/CHEAT_SHEET.md [cite: 63]
    cd ~/dotfiles || return [cite: 63]

    if test -f $target [cite: 63]
        sed -i "s/^> \*\*Last Synced:\*\*.*/> **Last Synced:** "(date "+%Y-%m-%d %H:%M")"/" $target [cite: 63]
    end

    git add . [cite: 63]

    echo -n "📝 Commit message (Enter for default): " [cite: 64]
    read msg [cite: 64]
    if test -z "$msg" [cite: 64]
        set msg "Manual Sync: "(date "+%Y-%m-%d %H:%M") [cite: 64]
    end

    git commit -m "$msg" [cite: 64]
    git push origin master [cite: 64]
    cd - [cite: 64]
    echo "🚀 GitHub updated and Cheat Sheet timestamped!" [cite: 64]
end

# 8. Global Update (FIXED END ADDED)
function update
    echo "🚀 Starting System Update..." 
    paru -Syu 

    echo "📂 Checking Dotfiles..." 
    cd ~/dotfiles || return 
    if not git diff --quiet 
        echo "✨ Changes detected! Backing up..." 
        git add . 
        git commit -m "Auto-backup: "(date +'%Y-%m-%d %H:%M') 
        git push origin master 
    else
        echo "✅ Dotfiles are already up to date." 
    end # <--- This was the missing end for 'if not git diff'
    cd - 
end # <--- This is the end for 'function update'
