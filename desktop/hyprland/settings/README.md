# Desktop Settings

Super+S opens a GTK 3 settings window in the collected [Hyprland session](../README.md). The pages cover output arrangement and scaling, backlight brightness, night light, audio, NetworkManager connections, BlueZ pairing, power profiles, the screen-off timer, keyboard repeat, pointing devices, active Hyprland shortcuts and system information. `desktop-settings --page power` opens a specific page. `desktop-settings --demo` uses simulated devices and keeps its changes in memory.

## Use with a session

Keep the [application files](.) together and put [desktop-settings](../bin/desktop-settings) and [desktop-settings-apply](../bin/desktop-settings-apply) together on the session PATH. Symlinks to the checked-out helpers resolve the adjacent application directory. If you copy the helpers, place this directory at `$XDG_CONFIG_HOME/hypr/desktop-settings` or set `DESKTOP_SETTINGS_DIR` to its location. `XDG_CONFIG_HOME` defaults to `~/.config`. The optional [desktop entry](applications/org.local.DesktopSettings.desktop) can go in `$XDG_DATA_HOME/applications`, usually `~/.local/share/applications`.

Run the [Hyprland session backend](../session/README.md) for settings restoration, the managed Hypridle screen-off timer and Hyprsunset. The window uses the Hyprland stylesheet in the session and falls back to the base style with `DESKTOP_SETTINGS_GLASS=0`. The stylesheet uses Terminus (TTF) when installed. The session can set `HYPRLAND_APP_FONTCONFIG_FILE` to expose application fonts independently of the bar font.

## Dependencies and behavior

| Controls | Runtime dependencies and adaptations |
| --- | --- |
| Application | Python 3.10+ with PyGObject, Pycairo and GTK 3 introspection, a user D-Bus session, Bash and `readlink`. Adwaita provides the symbolic icons. |
| Displays and shortcuts | Hyprland with its Lua configuration API and `hyprctl`, checked against 0.57.2. Outputs and advertised modes come from the compositor. Main display selects the mirror source and labels the chosen display in extended mode. Hyprland owns workspace placement. Mirrored outputs keep their own modes. The preview requires confirmation within 15 seconds and restores the prior layout on timeout or window exit. Restore Defaults reloads the session's Lua monitor rules. The session watcher replays confirmed layouts on connection changes and reload. |
| Brightness and warmth | `brightnessctl` with write access to a Linux backlight. DDC/CI brightness belongs to a monitor-specific tool. Hyprsunset and an output that supports gamma adjustment are needed for visible night light. Use the session's single neutral Hyprsunset profile so scheduled profiles do not override saved warmth. |
| Audio | `pactl`, `paplay` and `parec` from PulseAudio's client utilities, with PipeWire's PulseAudio service or a PulseAudio server. The service controls its default devices, volumes and mute. |
| Networking and Bluetooth | The NetworkManager service and its libnm typelib enable Wi-Fi and saved connection controls. The optional `nm-connection-editor` handles advanced and enterprise profiles. BlueZ and Python D-Bus bindings enable Bluetooth scanning and pairing. Use your system's Polkit policy and authentication agent. |
| Power | Systemd-logind and the session locker with target PAM configuration. The suspend button waits for Hyprland to confirm locking before requesting suspend. Power mode uses the profiles exposed by power-profiles-daemon or tlp-pd over D-Bus. Available profiles and authorization vary with the daemon and machine. Battery status and exposed charge limits come from sysfs. |
| Screen-off timer | The included session's managed Hypridle worker adds a DPMS listener to `$XDG_CONFIG_HOME/hypr/hypridle.conf`, retaining its lock and suspend hooks. Set the delay to zero to omit that listener. Keep a device-specific DPMS timeout out of the base config when using the screen-off control. |
| Pointing devices and repeat | Hyprland device rules use the device names from `hyprctl -j devices` and discover pointer types from udev. For unclear or duplicated names, map the exact Hyprland name in the defaults below. The defaults also describe any per-device adjustments already in Lua, since Hyprland exposes global input values through IPC. |

The CLI reads current power profiles with `desktop-settings-apply power-profiles`, applies one with `desktop-settings-apply power-mode balanced`, and reads or applies warmth with `desktop-settings-apply nightlight-level` and `desktop-settings-apply nightlight-level --intensity 45`. The app and bar share these settings and services.

## Machine defaults

Confirmed preferences are saved in `$XDG_CONFIG_HOME/desktop-settings/settings.json`. Optional `defaults.json` in the same directory, or `DESKTOP_SETTINGS_DEFAULTS`, can describe local hardware and overrides. The following example uses illustrative names.

```json
{
  "display": {
    "primaryOutput": "eDP-1",
    "blankAfterSeconds": 0
  },
  "keyboard": {
    "delay": 200,
    "rate": 50
  },
  "input": {
    "types": {
      "example-touchpad": "touchpad"
    },
    "devices": {
      "example-touchpad": {"speed": 0, "natural": true, "tapping": true}
    }
  }
}
```

Pointer types are `mouse`, `touchpad` and `pointing-stick`. Optional `input.mouse` and `input.touchpad` entries set per-type defaults. `display.primaryOutput` is the initial main-display preference, while the [hardware display example](../../../hardware/hyprland/config/workstation/hyprland-display.lua) owns the session's default connector and dock policy. Omit `keyboard` to restore the session's configured repeat values. `capabilities` can override detection with `hasBacklight`, `hasBluetooth`, `hasNightLight` and `hasPowerProfiles`. Optional `lockCommand` and `suspendCommand` are arrays of command arguments, resolved through the session PATH. The default locker is the shared Hyprland lock helper, or logind's lock request for a custom session. The default suspend command is `systemctl suspend`.

## Capture

Snapshot `snapshot-29` was captured on 2026-11-17 at commit `3df1b4e5ce9c2959a776b2c9421c5e5396bb0c00`. The GTK layout, styles, simulated devices and radio adapters come from that snapshot. The source package declares the MIT license. Hyprland IPC and session services supply the display, input, screen-off and shortcut operations. Launchers resolve dependencies through PATH and the settings directory follows XDG paths. Audio test playback generates its tone on demand. The [source records](../../../docs/sources.json) contain the file hashes.

Validation covered 12 GTK demo interactions on Xvfb, simulated worker restart and preference failure recovery, and an isolated Hyprland 0.57.2 session. The isolated compositor verified the native window class, active binding descriptions, output preview confirmation and rollback, and reversing the mirror source. Physical display, input, radio, lock and suspend behavior remain target-machine checks.
