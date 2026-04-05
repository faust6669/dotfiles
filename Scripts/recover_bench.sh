#!/usr/bin/fish

echo "🛠️ Rebuilding David's Python Bench..."

# 1. System Packages
sudo pacman -S --needed python-mido python-rtmidi python-numpy python-pyusb python-pyserial

# 2. AUR Packages (PyVISA)
if type -q paru
    paru -S --needed python-pyvisa python-pyvisa-py
else if type -q yay
    yay -S --needed python-pyvisa python-pyvisa-py
else
    echo "⚠️ No AUR helper found (paru or yay). Please install one!"
end

# 3. Permissions for Rigol/Korad
sudo usermod -aG uucp,dialout $USER
echo "✅ Done! You might need to log out and back in for USB permissions."
