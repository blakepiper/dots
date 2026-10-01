# Snapshot records

Collected on 2026-10-01 from the current machine and four source snapshots. Origin project names and URLs are omitted. Snapshot IDs in [sources.json](sources.json) retain capture commit IDs, original file hashes, current file hashes and known edits without exposing the original repository names. Local source paths are retained where useful.

| Snapshot | Material |
| --- | --- |
| snapshot-01 | OXWM, shared X11 session/helpers, display/input examples, Firefox policies |
| snapshot-02 | Hyprland Lua/session helpers and application settings, host display options, tmux |
| snapshot-03 | Alternate X11 keyboard/display hotplug examples and st customization |
| snapshot-04 | Niri, bar/panel helpers, Kitty, mountain wallpaper and keyd mapping |
| Local machine | KDE/SDDM/Neovim, wallpapers, Konsole, input and power rules, shell fragment |

Names in the collection describe the application, platform or function. Hyprland's helper and service names use `workstation`; Niri helpers use `desktop` for cache and application identifiers. The st shell wrapper is `st-shell`. Alternate X11 hardware files use `x11` names. References and dependent command paths were updated together.

The KDE screenshot service resolves its helper relative to the target home. Bash and X11 hardware settings include documented extracts. The X11 session PATH uses the user's local bin plus the inherited system PATH; authentication still requires a target-appropriate privileged locker. Platform-specific Scheme references were replaced by the reusable shell examples and [OXWM build notes](../desktop/oxwm/reference/build.md).

Imported license and copyright notices remain intact. The st license is under `terminal/st/`; the Niri material's source license is under `desktop/niri/`. The clipboard watcher retains its MIT SPDX notice. No blanket license or image authorship was invented for the collection. Wallpaper-specific rights remain unestablished by these filenames.

No credentials, browser accounts, usage caches, shell histories, restored sessions, downloaded plugin trees or installer backups were collected. No machine settings were activated.

Collection reorganization on 2026-10-01 groups desktops and SDDM under `desktop/` and moves shared Bash to `shell/bash/`. Hyprland Nix modules and their lock were replaced with plain Lua, Bash, application configs and systemd user units derived from snapshot-02. Hardware display values are in `hardware/hyprland/`; Foot settings are in `terminal/foot/`. The custom workspace buttons replace the Waybar source patch. Validation was skipped at the user's request.

A subsequent platform pass on 2026-10-01 isolates Hyprland user units from shared configs, adds a portable session supervisor, separates Niri Awake inhibition backends, introduces shared configurable power commands, factors battery activation into shared behavior plus OpenRC/systemd/udev adapters, makes the X11 locker path configurable, and relocates optional tmux Nix packaging. Niri network detection now queries NetworkManager directly rather than systemctl. Captured implementations remain where they are meaningful alternatives. No account/service/hardware helpers were run and validation was skipped.
