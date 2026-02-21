# 🐧 Dave's 2026 CachyOS & i5-12th Gen Master Sheet
> **Last Synced:** 2026-02-21 02:55
## 💻 Hardware & System Core
- **CPU:** Intel i5-12th Gen (Hybrid Architecture)
  - **P-Cores:** 0-11 (Performance / Heavy Lifting)
  - **E-Cores:** 12-15 (Efficiency / Background)
- **Architecture:** `x86-64-v3` (Optimized Repos Active)
- **Kernel:** `linux-cachyos-bore`

---

## 🚀 Performance & Scheduling (SCX)
The **LAVD** scheduler ensures games stay on P-cores to prevent stuttering.

| Command | Action |
| :--- | :--- |
| `scxctl switch -s lavd -m gaming` | **Enable Gaming Mode** (Hybrid-aware) |
| `scxctl get` | Check which scheduler is currently active |
| `btop` | Monitor per-core load (Watch P-cores for games) |
| `sudo dmesg \| grep sched_ext` | Verify the scheduler framework is loaded |

---

## 🐚 Fish Shell & Terminal Workflow
- **Primary Shell:** Fish
- **Terminal:** WezTerm

### 📋 Custom Commands & Aliases
- **`dots`**: Master sync. Navigates to `~/dotfiles`, commits, and pushes to GitHub.
- **`cheat`**: Runs `cat ~/dotfiles/CHEAT_SHEET.md` to show this file.
- **`update`**: Runs `yay -Syu` to sync v3 optimized packages.
- **`..` / `...`**: Quick directory jumping.

### ⌨️ WezTerm Shortcuts
- `Ctrl + Shift + R`: Reload configuration (applies Lua changes).
- `Ctrl + Shift + L`: Open debug overlay (checks for Lua errors).
- `Ctrl + Shift + F`: Search terminal scrollback.

---

## 🎮 Gaming & Graphics
- **Proton Version:** Use `Proton-CachyOS` (v3 optimized) for best i5 performance.
- **Steam Launch Options:** `mangohud gamemoderun %command%`
- **Environment Flags:** (Defined in `config.fish`)
  - `GAMEMODERUN=1`: Triggers CPU priority.
  - `MANGOHUD=1`: Shows performance overlay.
  - `NODEVICE_SELECT=1`: Fixes GPU device picking.

---

## 📂 Dotfiles & Git Management
Configs are stored in `~/dotfiles` and managed via `install.sh`.

### To update your GitHub backup:
1. Make changes to any config files.
2. Run the `dots` command from any directory.
3. Git commit message defaults to a timestamped "Manual Sync".

---

## 🛠️ Emergency / Recovery
- **Reload Fish:** `source ~/.config/fish/config.fish`
- **Fix Audio:** `fixaudio` (or `audio-init`)
- **Reset Scheduler:** `sudo systemctl restart scx`


## WezTerm Tiling & Keybinds

     key = 'W', mods = 'CTRL|SHIFT', 
     key = 'A', mods = 'CTRL|SHIFT', 
     key = 'S', mods = 'CTRL|SHIFT', 
     key = 'D', mods = 'CTRL|SHIFT', 
     key = 'h', mods = 'ALT', 
     key = 'l', mods = 'ALT', 
     key = 'k', mods = 'ALT', 
     key = 'j', mods = 'ALT', 
     key = 'e', mods = 'ALT', 
     key = 'r', mods = 'ALT', 
     key = 't', mods = 'ALT', 
     key = '[', mods = 'ALT', 
     key = ']', mods = 'ALT', 
     key = 'Enter', mods = 'ALT', 
     key = 'R', mods = 'ALT|SHIFT', 
     key = 'e', mods = 'CTRL', 
     key = 'w', mods = 'ALT', 
