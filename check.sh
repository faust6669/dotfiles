#!/bin/bash
# A simple script to verify if your dotfiles are nested correctly for Stow

echo "--- Dotfiles Sanity Check ---"
for dir in */; do
    # Remove trailing slash
    folder=${dir%/}

    # Check if the folder contains a .config directory
    if [ -d "$folder/.config" ]; then
        echo "✅ $folder: Correctly nested (.config found)"
    elif [[ "$folder" == "scripts" || "$folder" == "bin" ]]; then
        echo "ℹ️  $folder: Skipping (special folder)"
    else
        echo "❌ $folder: FLAT STRUCTURE! (Stow will put this in your home folder, not .config)"
    fi
done
