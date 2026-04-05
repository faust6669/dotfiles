#!/bin/bash
# 1. Install System Essentials (CachyOS/Arch)
sudo pacman -S --needed eza fastfetch starship wezterm stow micro git python-pip

# 2. Setup Dotfiles
cd ~/dotfiles
stow -v */

# 3. Rebuild the Python Bench
pip install -r ~/dotfiles/scripts/bench_requirements.txt

# 4. Hardware Permissions (Crucial for your Rigol/USB tools)
# Adds you to the groups needed to talk to USB hardware without sudo
sudo usermod -aG lp,uucp,dialout $USER
