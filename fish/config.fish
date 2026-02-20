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

