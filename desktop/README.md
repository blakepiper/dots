# Desktop sessions and greeter

- [KDE](kde/README.md): Plasma settings, KWin scripts and panel assets.
- [OXWM](oxwm/README.md): window manager configuration, helpers and source patches.
- [X11](x11/README.md): supporting session, compositor, clipboard and lock helpers used by OXWM.
- [Hyprland](hyprland/README.md): Lua config and shared helpers with systemd/portable session backends.
- [Niri](niri/README.md): scrolling desktop, bar and session helpers.
- [SDDM](sddm/README.md): login greeter settings and theme.

Device settings live under [hardware](../hardware/README.md), terminal emulators under [terminal](../terminal/README.md), and Bash under [shell](../shell/README.md). Each desktop documents its sibling dependencies.

Choose helper commands per session: KDE and X11 both supply `screenshot-region`; Niri and X11 both supply `clipboard-history` and `control-menu`. Merging all their `bin/` directories into one destination overwrites those commands. Shared application configs such as Waybar/Fuzzel likewise need an explicit choice or merge.

[Shared desktop integration](common/README.md) holds selectable power-command profiles and polkit agent discovery. Session-manager alternatives live under the affected desktop's `session/` directory rather than duplicating its application configs.
