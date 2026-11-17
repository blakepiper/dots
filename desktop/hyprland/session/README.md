# Hyprland session backends

Use `HYPRLAND_SESSION_BACKEND=systemd hyprland-session` for the systemd setup, or `hyprland-session` for direct supervision with the default portable backend. Run it from a login shell outside a desktop. The wrapper selects the optional Tamsyn Fontconfig file, starts Hyprland with its watchdog when available and cleans up the chosen backend after the compositor exits.

Copy the selected backend directory into `~/.config/hypr/session/<backend>/` and put the [Hyprland helpers](../bin/) on PATH. The Lua startup hook invokes `workstation-hyprland-session`, which uses the same backend. Both backends need the login's private `XDG_RUNTIME_DIR` and D-Bus session. They start Quickshell, wallpaper and Hypridle, with Hyprsunset and the Settings watcher when their tools are available.

## systemd

Copy `systemd/user/*` into `~/.config/systemd/user/` and reload with `systemctl --user daemon-reload` when adopting the config. The startup hook imports the display, compositor and application environment and starts `workstation-hyprland-session.target`. The target groups the units and stops them together. Services restart on failure. The wrapper also clears the session environment and stops the per-user portal processes around session changes so they can reactivate with the appropriate display.

The Hyprsunset unit applies the saved night light setting after starting. The Settings watcher restores saved display, input and appearance choices and responds to compositor events. The idle unit uses the Settings runtime to apply any saved display idle timeout, with the shared `hypridle.conf` otherwise. Hypridle requests Hyprlock directly before suspend so the user service can lock the compositor from its own process context. The lock key and power menu also need `loginctl`, Hyprlock's PAM setup, and the [shared systemd power profile](../../common/README.md).

The older clipboard capture unit is available as an option. Install `wl-clipboard` and Cliphist and use `systemctl --user add-wants workstation-hyprland-session.target workstation-hyprland-clipboard.service` to attach it to the target. The matching popup helper uses Fuzzel. Add a binding if you want it exposed.

## Portable

The Bash supervisor tracks the same child commands, holds a session lock and cleans up after the compositor's IPC connection disappears. It uses `flock` and polls `hyprctl`. For restart-on-failure and GUI-managed service control, use the systemd backend. D-Bus activation or the platform's service manager supplies the portal daemons. Select the power-command profile for the target separately. [Power profile selection](../../common/README.md)

Both backends use `HYPRLAND_WALLPAPER` for a custom absolute wallpaper path. Local `~/Pictures/horizon.png` is the example default and a missing image gives a solid background. General-purpose font and application configs also work with other sessions. [Horizon wallpaper](../../../walls/horizon.png)

Snapshot `snapshot-29`, 2026-11-17, retains both existing supervision backends and adapts the captured Quickshell, Hypridle and Hyprsunset startup to them. [Source records](../../../docs/sources.json)
