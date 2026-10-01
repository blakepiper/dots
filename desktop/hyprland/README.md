# Hyprland

Plain Lua configuration and Bash helpers with systemd or portable session supervision. No Nix, Home Manager, flake, generated substitutions, or patched Waybar is required. Derived on 2026-10-01 from snapshot-02; capture commit and file hashes are recorded in [sources](../../docs/sources.json).

The Lua config retains the captured Hyprland 0.56 Lua API: install a compatible compositor. It provides nine numbered workspaces, master/dwindle layouts, stack navigation, opaque colors, two-pixel borders and no animations, rounding, blur or shadows. See [keybindings](../../keybinds/README.md).

Merge `config/hypr/`, `config/fuzzel/`, and `config/waybar/` into their corresponding directories under `~/.config/`. Put the chosen `bin/` helpers on PATH, normally in `~/.local/bin/`. Foot settings live in [terminal/foot](../../terminal/foot/foot.ini) and map to `~/.config/foot/foot.ini`; use [Bash with ble.sh](../../shell/bash/README.md).

The Lua config reads `~/.config/workstation/hyprland-display.lua` (honoring `XDG_CONFIG_HOME`). Copy and adapt the [hardware example](../../hardware/hyprland/config/workstation/hyprland-display.lua): `eDP-1`, scale 1.8 and 1920×1080 at 60 Hz describe the captured panel/dock policy. External connectors are discovered dynamically and mirrored; undocking restores the internal preferred mode. Keyboard device names and the WhiteSur cursor theme also need adapting. Choose one keyboard remapping layer.

Choose a [session backend](session/README.md): the systemd variant preserves the captured user-service behavior; the portable variant supervises the same helpers directly. The shared `hyprland-session` wrapper and Lua config work with either. D-Bus remains a dependency. The portable backend is the default. Power menus require `desktop-power` from [desktop/common](../common/README.md) and a selected power-command profile.

Services start Waybar, text clipboard capture, swaybg and Hypridle. The wallpaper helper uses `~/Pictures/horizon.png`, or `HYPRLAND_WALLPAPER` when set in the user service environment; a missing image gives a solid background. [Horizon](../../walls/horizon.png) is included. Hypridle requests locking before suspend without timed idle listeners. The lock helper shares one Hyprlock instance through flock. The target system must supply Hyprlock's PAM integration.

Dependencies: Hyprland with the captured Lua API, Foot, Bash, Fuzzel, Firefox, Xfe, WirePlumber/wpctl, playerctl, brightnessctl, Waybar, Hyprlock, Hypridle, swaybg, wl-clipboard, Cliphist, grim, slurp, jq, D-Bus, util-linux/flock, GNU coreutils and JetBrainsMono Nerd Font. Portal integration needs xdg-desktop-portal and an appropriate Hyprland/GTK backend. Applications and helper commands resolve through PATH instead of package-store paths. The systemd backend additionally requires a systemd user manager; the portable backend uses Bash/flock process supervision.

Waybar uses nine ordinary custom workspace buttons with Lua dispatcher commands and active-workspace polling. This replaces the captured build-time Waybar patch. Screenshots support region/full/window capture, save under `~/Pictures/Screenshots`, and copy the PNG. The control menu offers lock, suspend, logout, display power and system power actions.

These configs share destination names with other desktops' Fuzzel, Waybar and locker examples. Choose or merge those application settings deliberately. No installer is included and no settings were activated. Validation was skipped for these conversions at the user's request.
