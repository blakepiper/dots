# Hyprland

This is the Lua session with Quickshell's workspace, calendar and system-control panes, Wofi launchers, and GTK Desktop Settings. It uses commands on PATH and works with either of the [session backends](session/README.md).

| Source | Destination or use |
| --- | --- |
| `config/hypr/` | Merge into `~/.config/hypr/` for the compositor, fonts, locker, idle handling and night light. |
| `config/quickshell/` | Merge into `~/.config/quickshell/`, keeping `shell.qml` and its samplers together. |
| `config/wofi/` | Merge into `~/.config/wofi/` for both menus. |
| `bin/` | Put the selected commands on PATH, typically in `~/.local/bin/`. |
| [Ghostty](../../terminal/ghostty/README.md) | Merge the shared configuration and Hyprland overlay into `~/.config/ghostty/`. |
| [Desktop Settings](settings/README.md) | Keep its GTK app and runtime helpers available for Super+S and the bar. |

The launchers and config paths honor `XDG_CONFIG_HOME`. Hyprland 0.57.2 and Quickshell 0.3.2 with Qt 6.12 supplied the capture. Install a Hyprland release with the 0.57 Lua API and a Quickshell build with Hyprland, PipeWire and Wayland integration. The bar uses Terminus (TTF) and JetBrainsMono Nerd Font. The `hypr/fontconfig.conf` file selects Tamsyn Bold for general session apps. Install Tamsyn separately and start via `hyprland-session` to select it only for this session.

### Shortcuts and panels

- **Super+Space** and **Super+D** open Wofi's application search with icons. **Super+Shift+Space** opens Wofi's lock, suspend, reboot, logout, display-off and power-off menu. Confirmations protect log out, reboot and power off. Select the shared power helper and profile for the target login. [Power profiles](../common/README.md)
- **Super+S** opens Desktop Settings. Quickshell and the app share the power-mode and night light controls. Start the systemd backend for supervised Settings, Hypridle and Hyprsunset processes. [Session backends](session/README.md)
- **Super+Enter** opens the glass Ghostty terminal. Firefox, Thunar and optional Steam have their own shortcuts. **Super+Shift+S** captures a region and **Print** captures the full screen. Both write a PNG to `~/Pictures/Screenshots` and copy it. [Shortcut details](../../keybinds/README.md)

The panel uses PipeWire/WirePlumber for volume, `brightnessctl` and `/sys/class/backlight` for backlight, Linux sysfs for battery, and the Settings runtime for power mode and night light. Hardware controls appear when their dependencies are present. The system-info menu starts its Python sampler while open. Linux GPU data sources vary with the driver, and `nvidia-smi` is optional. The workspace badge uses a general grid icon.

The compositor uses dwindle splits, rounded corners, 85% active and 80% inactive opacity, and natural scrolling. To get the captured glass effect, build HyprGlass against the exact installed Hyprland and export `HYPRGLASS_PLUGIN` as the absolute `.so` path before launch. The capture used revision `dc00c628623e5e504b363e26dd489ee766d2fa12` from the 0.57 release line. The configured materials target Ghostty, Desktop Settings, Wofi and the three Quickshell panes. Built-in layer blur and translucent backgrounds work with the default compositor alone. [HyprGlass build instructions](https://github.com/hyprnux/hyprglass/blob/main/README.md)

The settings and terminal wrappers use their own background alpha. Steam game windows stay opaque. To enable Firefox video opacity matching, use the collected extension that sets the `[firefox-video] ` title marker. [Firefox video opacity](../../browser/firefox/video-opacity/README.md)

### Target hardware and session dependencies

For a laptop with automatic dock mirroring, copy the optional [monitor example](../../hardware/hyprland/config/workstation/hyprland-display.lua) into `~/.config/workstation/hyprland-display.lua` and set `primary_output` to the internal connector. The policy prefers a connected external output as the mirror source, keeps each output's preferred mode and restores automatic scale on the internal panel when undocked. Desktop Settings can apply an explicit arrangement. With no monitor file, Hyprland chooses the default monitor configuration.

The lock and brightness helpers depend on Hyprlock with PAM, Hypridle and logind-compatible session locking, and writable backlight access through the distro's normal seat/device policy. The other helpers use Bash, swaybg, grim, slurp, wl-clipboard, util-linux/flock and GNU coreutils. The extra `--window` screenshot mode and the earlier Waybar workspace helper use `jq`. Audio and media shortcuts use `wpctl` and `playerctl`. For screen sharing and file dialogs, supply D-Bus, xdg-desktop-portal and the relevant Hyprland/GTK portals. Settings has its own radio, privilege and service dependencies.

The earlier Fuzzel and Waybar configs and the Cliphist helpers remain as reference alternatives. To use them, select the earlier assets and adapt the relevant launcher binding or session bar command. For clipboard history, start the text capture worker and add a binding to `workstation-hyprland-clipboard`. [Session alternatives](session/README.md)

Snapshot `snapshot-29`, 2026-11-17, captures the Lua config, Quickshell and samplers, Wofi themes, session font and the Ghostty overlay. The adaptation replaces generated substitutions with PATH, Linux capability discovery, optional display data and session-owned services. The lock theme, wallpaper helper, extended screenshot helper and alternate app examples are from the earlier collection. [Source records](../../docs/sources.json)
