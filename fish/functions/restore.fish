function restore --wraps='~/dotfiles/setup.fish && source ~/.config/fish/config.fish' --description 'alias restore=~/dotfiles/setup.fish && source ~/.config/fish/config.fish'
    ~/dotfiles/setup.fish && source ~/.config/fish/config.fish $argv
end
