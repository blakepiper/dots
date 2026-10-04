# Platform integration boundaries

The collection organizes shared settings by application or function. Alternatives belong at the point where platform behavior changes; they do not require complete systemd/non-systemd copies of each module.

| Boundary | Shared material | Alternatives |
| --- | --- | --- |
| [Hyprland session](../desktop/hyprland/session/README.md) | Lua, bar, wallpaper, clipboard, lock and control helpers | systemd user services or portable process supervisor |
| [Niri Awake](../desktop/niri/session/README.md) | KDL, bar UI, idle guards and application startup | systemd-inhibit service or directly supervised elogind-inhibit |
| [Desktop power](../desktop/common/README.md) | Control menus call `desktop-power` | systemctl, elogind loginctl, or adapted direct commands |
| [X11 locker](../desktop/x11/session/README.md) | Session and lock scripts | PATH-resolved i3lock or captured privileged-program path |
| [Battery activation](../hardware/power/README.md) | Charge-threshold helper | OpenRC, systemd or dinit boot hook; optional udev hotplug |
| [tmux packaging](../terminal/tmux/README.md) | tmux.conf | Optional Nix package expression |

Select an alternative per boundary. A portable compositor session may still use elogind for authentication/suspend integration; an OpenRC machine may use udev for devices. None of those dependencies alone means the session needs systemd service management. D-Bus and portal activation remain target responsibilities.

Some differences are already properly isolated: keyboard mappings use hwdb, keyd or compositor/XKB layers; hardware display policies live under `hardware/`; KDE uses ordinary D-Bus activation; SDDM is its own greeter module; st/OXWM build patches stay with those applications. These retain their required runtimes and device assumptions. They do not need invented service-manager variants. Choose one keyboard remapping layer and one desktop's overlapping helper commands at a time.

Preserve captured implementations when they provide a useful alternative. Records document moves, original hashes and adaptations; application preferences are not duplicated merely to retain a captured platform's packaging. Alternative backends can differ in restart behavior and external service management, as their READMEs explain.

This integration pass was made on 2026-10-01. No service, compositor, power operation or hardware setting was activated. Validation was skipped at the user's request; earlier validation notes do not cover this pass.

`collection-03`, 2026-10-03, adds only a dinit battery service adapter over the shared helper. Artix package paths, policy update ownership and existing service graph are adaptation facts, not reasons to duplicate KDE/application modules or replace init. See [validation](validation.md) and [source records](sources.json).
