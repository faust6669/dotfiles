  # 1. Load Distro Defaults
if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

# 2. PATHS
if test -d ~/.config/emacs/bin
    set -gx PATH $PATH ~/.config/emacs/bin
end

# 3. ALIASES
alias dsync='~/.emacs.d/bin/doom sync'
alias fastfetch="fastfetch -c ~/.config/fastfetch/config.jsonc --logo arch"
alias graph="qpwgraph -a ~/mystudio.xml &"
alias fix-audio="qpwgraph -a ~/working_setup.xml &; wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%"

# 4. THE NUCLEAR OPTION: Redefine the greeting function
# This overwrites whatever CachyOS is trying to do.
function fish_greeting
    if status is-interactive
        # This is the ONLY place fastfetch will run
        command fastfetch -c ~/.config/fastfetch/config.jsonc --logo arch
    end
end

# 5. ABBREVIATIONS
if status is-interactive
    abbr -a tt '~'
    abbr -a --position anywhere tt '~'
    abbr -a update 'sudo pacman -Syu'
    abbr dots 'cd ~/dotfiles && git add . && git commit -m "Update configs" && git push && cd -'
end

# 6. PROMPT
starship init fish | source

# CachyOS & Intel 12th Gen Gaming Tweaks
set -gx GAMEMODERUN 1
set -gx NODEVICE_SELECT 1
# Uncomment the line below if you want the FPS overlay on EVERY game automatically
# set -gx MANGOHUD 1

function dots --description 'Sync dotfiles and update timestamp'
    set -l target ~/dotfiles/CHEAT_SHEET.md
    cd ~/dotfiles

    # Update the "Last Synced" line in your Cheat Sheet
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
    git push origin main
    cd -
    echo "🚀 GitHub updated and Cheat Sheet timestamped!"
end

