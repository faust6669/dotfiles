#!/usr/bin/env fish

echo "--- 🛠️  Installing Dependencies ---"
# Check for pacman (Arch/CachyOS) and install required tools
if command -v pacman > /dev/null
    sudo pacman -S --needed stow fastfetch starship wezterm yazi bat cava
end

echo "--- 🚀 Deploying Dotfiles ---"
# 1. Ensure we are in the dotfiles directory
cd (dirname (status filename))

# 2. Fix the Fish function path manually [cite: 1, 2, 10]
# This links cheat.fish without wiping your existing config.fish
mkdir -p ~/.config/fish/functions
ln -sf (pwd)/fish/.config/fish/functions/cheat.fish ~/.config/fish/functions/cheat.fish

# 3. Deploy the nested packages using Stow [cite: 1, 3]
for folder in cava fastfetch starship wezterm yazi
    stow -v --adopt $folder
end

# 4. Revert any local system changes pulled in by --adopt
git checkout .

# 5. Initialize Starship in config.fish if not already there 
if not grep -q "starship init fish" ~/.config/fish/config.fish
    echo "starship init fish | source" >> ~/.config/fish/config.fish
end

echo "--- 🎉 All done! Restart Fish to see your new prompt. ---"
