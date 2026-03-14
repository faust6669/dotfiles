# 1. Disable the CachyOS greeting and the "double" function
set -g fish_greeting ""
functions -e fastfetch 2>/dev/null

# 2. Initialize Starship (The Theme)
if type -q starship
    starship init fish | source
end

# 3. Path and Editor setup
if test -d ~/.config/emacs/bin
    set -gx PATH $PATH ~/.config/emacs/bin
end

# 4. Aliases and Abbreviations
alias dsync='~/.emacs.d/bin/doom sync'
alias dots='cd ~/dotfiles && git add . && git commit -m "Update configs" && git push && cd -'

if status is-interactive
    # The Tilde shortcut for your 60% board
    abbr -a tt '~'
    # Update shortcut
    abbr -a update 'sudo pacman -Syu'

    # 5. Run your Custom Fastfetch ONCE
    # We point to your specific config and force the Arch logo here
    command fastfetch --config ~/.config/fastfetch/config.jsonc --logo arch
end

