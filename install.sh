
#!/usr/bin/env bash

# --- AUTOMATED SETUP SCRIPT ---
# Tailored for CachyOS / Arch-based environments

# Color codes for clean output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0;0m' # No Color

echo -e "${BLUE}Starting automated workspace deployment...${NC}"

# --- 1. PACKAGE INSTALLER LOOP ---
echo -e "${BLUE}Checking package requirements...${NC}"

# Detect AUR helper (prefers paru, falls back to yay)
if command -v paru &> /dev/null; then
    AUR_HELPER="paru"
elif command -v yay &> /dev/null; then
    AUR_HELPER="yay"
else
    echo -e "${RED}Error: Neither paru nor yay was found! Please install an AUR helper first.${NC}"
    exit 1
fi

echo -e "${GREEN}Using helper: ${AUR_HELPER}${NC}"

# Read packages.txt and bulk install cleanly
PACKAGES_FILE="$HOME/dotfiles/packages.txt"

if [ -f "$PACKAGES_FILE" ]; then
    echo -e "${BLUE}Reading installation targets from packages.txt...${NC}"
    # Read file line by line, stripping comments and empty lines
    sed -e 's/#.*//' -e '/^$/d' "$PACKAGES_FILE" | while read -r package; do
        if ! pacman -Qi "$package" &> /dev/null && ! pacman -Qg "$package" &> /dev/null; then
            echo -e "${BLUE}Installing: ${package}...${NC}"
            $AUR_HELPER -S --noconfirm "$package"
        else
            echo -e "${GREEN}✓ ${package} is already installed.${NC}"
        fi
    done
else
    echo -e "${RED}Warning: packages.txt not found at ${PACKAGES_FILE}. Skipping bulk install.${NC}"
fi

# --- 2. CONFIGURATION SYMLINKS (STOW / ADOPT WORKFLOW) ---
echo -e "${BLUE}Linking configuration environments...${NC}"

# Ensure directories exist before managing links
mkdir -p "$HOME/.config/fish"
mkdir -p "$HOME/.config/wezterm"
mkdir -p "$HOME/.config/yazi"

# Move to dotfiles directory to execute stow execution safely
cd "$HOME/dotfiles" || exit

# Symlink configurations, adopting any active target files automatically
stow --adopt -v -t "$HOME" fish wezterm yazi starship

# --- 3. KDE PLASMA KEYBOARD SHORTCUTS ---
echo -e "${BLUE}Configuring WezTerm Global Shortcut...${NC}"
SHORTCUT_KEY="Ctrl+Shift+E"

if command -v kwriteconfig6 &> /dev/null; then
    # Create the native application launch entry for WezTerm in Plasma 6
    kwriteconfig6 --file kglobalshortcutsrc --group "org.wezfurlong.wezterm.desktop" --key "_launch" "$SHORTCUT_KEY,none,Launch WezTerm"

    # Reload the global shortcut daemon to apply changes immediately
    dbus-send --print-reply --dest=org.kde.kglobalaccel /component/org_wezfurlong_wezterm_desktop org.kde.kglobalaccel.Component.reloadSettings &> /dev/null

    echo -e "${GREEN}✅ Shortcut set:${NC} Press $SHORTCUT_KEY to launch WezTerm."
else
    echo -e "${RED}Notice: kwriteconfig6 not found. Skipping shortcut automation.${NC}"
fi

echo -e "${GREEN}🎉 Deployment complete! Run 'fresh' to spin up your new terminal environment.${NC}"
