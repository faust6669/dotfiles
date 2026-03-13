
#!/bin/bash

# 1. Define where your dots are (Get current directory)
DOTFILES_DIR=$(pwd)

# 2. List the folders/files you want to link
# Add your specific folder names here (e.g., "fastfetch", "sway", "plasma")
CONFIGS=("fastfetch" "konsole" "kglobalshortcutsrc" "plasmarc")

echo "Starting CachyOS Plasma Dotfile Deployment..."

# 3. Create .config if it doesn't exist
mkdir -p ~/.config

for folder in "${CONFIGS[@]}"; do
    if [ -e "$DOTFILES_DIR/$folder" ]; then
        echo "Linking $folder..."
        # Remove existing file/link to avoid "folder inside folder" errors
        rm -rf "$HOME/.config/$folder"
        # Create the new link
        ln -sf "$DOTFILES_DIR/$folder" "$HOME/.config/$folder"
    else
        echo "Warning: $folder not found in repo, skipping."
    fi
done

echo "Done! Restart Plasma (or log out/in) to see changes."
