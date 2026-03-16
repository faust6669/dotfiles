#!/usr/bin/env fish

echo "--- 🚀 Starting Dotfiles Deployment ---"

# 1. Ensure we are in the dotfiles directory
cd (dirname (status filename))

# 2. Fix known Fish function conflicts
# This links cheat.fish without taking over the whole ~/.config/fish dir
mkdir -p ~/.config/fish/functions
ln -sf (pwd)/fish/.config/fish/functions/cheat.fish ~/.config/fish/functions/cheat.fish
echo "✅ Fish function linked"

# 3. Deploy everything else using Stow
# --adopt handles existing files; -v gives us feedback
for folder in cava fastfetch starship wezterm yazi
    stow -v --adopt $folder
end

# 4. Clean up Git
# If stow --adopt pulled in local system changes, revert them to keep repo clean
git checkout .

echo "--- 🎉 Setup Complete! ---"
echo "Note: If this is a new install, remember to add \"starship init fish | source\" to your config.fish"
