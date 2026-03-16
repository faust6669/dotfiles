function cheat --description 'Show my cheat sheet'
    if command -v bat > /dev/null
        bat --style=plain ~/dotfiles/CHEAT_SHEET.md
    else
        cat ~/dotfiles/CHEAT_SHEET.md
    end
end
