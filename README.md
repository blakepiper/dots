# dots

Personal configuration raw material for people and agents to inspect, borrow, and adapt across machines. Pick individual modules; each directory explains its destinations and dependencies. There is no installer or requirement to adopt the whole collection.

| Module | Contents |
| --- | --- |
| [walls](walls/README.md) | Cityview, sunset, horizon, and night wallpapers |
| [nvim](nvim/README.md) | Current LazyVim config, plugin lock, minimal theme, and `nvimide` |
| [kde](desktop/kde/README.md) | Plasma/KWin and Dolphin settings, custom tiling and focus border, panel widgets, screenshot integration |
| [sddm](desktop/sddm/README.md) | Current greeter config and custom minimal theme |
| [oxwm](desktop/oxwm/README.md) | Lua config, status helpers, and three source patches |
| [hyprland](desktop/hyprland/README.md) | Lua config, shared helpers and systemd/portable session backends |
| [niri](desktop/niri/README.md) | KDL config, Waybar, launcher, notifications, locking and session helpers |
| [hardware](hardware/README.md) | LG display snapshot, external keyboard mapping, dock hotplug behavior, pointer and battery settings |
| [keybinds](keybinds/README.md) | Preferred keyboard vocabulary and actual differences between desktops |
| [terminal](terminal/README.md) | Konsole, Kitty, Foot, st customization, tmux and neofetch |
| [shell](shell/README.md) | Shared Bash startup with ble.sh |
| [desktop/common](desktop/common/README.md) | Shared GTK/Fontconfig settings, power-command profiles and polkit helper |
| [desktop/x11](desktop/x11/README.md) | Session, compositor, clipboard, screenshots, locking, and control menu |
| [browser](browser/README.md) | Firefox interface styling, profile preferences, and policy reference |

Start with [keybinds](keybinds/README.md) for behavior, then the application or desktop you want. Hardware choices are independent of desktop preferences. Desktop sessions and the greeter live under `desktop/`; terminal emulators live under `terminal/`, and interactive Bash under `shell/`. Hyprland uses plain configs and scripts. See [desktop composition](desktop/README.md) for dependencies and overlapping helper names.

Captured 2026-10-01. KDE/SDDM/Neovim material reflects the local machine. These are different snapshots, so differences in fonts, workspaces, repeat rates, and display scaling are deliberate records of the source environments.

[Adaptation notes](docs/adapting.md) explain machine-specific paths and IDs. [Source records](docs/sources.md) record snapshot commits, local paths and known edits; [sources.json](docs/sources.json) gives per-file hashes. [Repository conventions](AGENTS.md) guide future collection work.

Platform differences stay at the integration boundary: desktop session choices under `desktop/*/session/`, shared power commands under `desktop/common/`, battery activation under `hardware/power/activation/`, and optional package selection under `terminal/tmux/platform/`. Shared application configs remain single copies. See [platform notes](docs/platforms.md).
