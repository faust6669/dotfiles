# ⚡ Dave's 2026 CachyOS Power-Sheet

## 🐚 Fish Abbreviations & Aliases
| Abbr | Command | Why? |
| :--- | :--- | :--- |
| `cheat` | `cat ~/dotfiles/CHEAT_SHEET.md` | Open this guide |
| `conf` | `cd ~/.config/` | Quick jump to settings |
| `..` | `cd ..` | Faster navigation |
| (Add yours here) | | |

## 🖥️ WezTerm Keybinds
* `Ctrl + Shift + R`: Reload WezTerm config (Fixes display glitches).
* `Ctrl + Shift + L`: Show Debug Overlay.
* `Ctrl + Shift + F`: Search scrollback.

## 🚀 Hybrid CPU Management (i5-12th Gen)
* **Gaming Mode:** `scxctl switch --sched lavd --mode gaming`
* **Check Repos:** `grep cachyos-v3 /etc/pacman.conf`
* **Verify BPF:** `sudo dmesg | grep sched_ext`

## 🎮 Game Launch Options (Steam)
> Right-click game > Properties > Launch Options:
`mangohud gamemoderun %command%`
