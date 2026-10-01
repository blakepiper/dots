# Niri

Collected 2026-10-01. The module includes a source license and snapshot/hash records in `../../docs/sources.json`. Config names and helper cache/application identifiers describe their function. There is no installer in this module.

`config/niri/config.kdl` maps to `~/.config/niri/config.kdl`. It defines nine named workspaces, scrolling columns, eight-pixel gaps, half-width columns with one-third/half/two-thirds presets, a two-pixel focus ring, and floating rules for selected applications. Its display examples are disabled with KDL `/-`; they are examples, not active output rules. This snapshot uses spatial column/window navigation and some transparency, unlike the collected OXWM and Hyprland preferences.

| Material | Target/reference |
| --- | --- |
| `config/niri/` | `~/.config/niri/` |
| `config/waybar/`, `config/fuzzel/`, `config/mako/` | Corresponding directories under `~/.config/` |
| `config/hypr/hyprlock.conf` | `~/.config/hypr/hyprlock.conf`; locker for this Niri session |
| `session/` | Choose the [systemd or portable Awake backend](session/README.md) |
| `bin/` | `~/.local/bin/`; preserve `ai-usage-scanners/` beside `ai-usage` |
| [Kitty config](../../terminal/kitty/kitty.conf) | `~/.config/kitty/kitty.conf` |
| [Mountain wallpaper](../../walls/mountain.png) | Config expects `~/Pictures/mountain.png` |
| [Keyboard mapping](../../hardware/keyboard/keyd/external-keyboard.conf) | `/etc/keyd/external-keyboard.conf`; optional device-specific alternative |
| `reference/TOPBAR-DESIGN.md` | Original notes explaining the bar and its controls |

Session startup launches Mako, Waybar, swaybg, the KDE polkit agent, gnome-keyring, udiskie, text/image clipboard watchers, swayidle and the night-mode helper. Idle defaults request locking after 600 seconds, monitor power-off after 900 seconds, and locking before sleep. The Awake toggle uses the selected inhibitor backend and guards automatic idle actions. Lock/suspend behavior requires working target PAM/session integration and should be verified before use.

Supporting helpers provide clipboard selection, a control menu, display discovery, night temperatures (off / 3500 K / 2200 K), battery/power controls, network/audio panels and the optional AI usage widget. Waybar references the included Python GTK panel and AI scanners, so they are retained as supporting source. The AI widget can read the adopting user's local CLI account/usage state and query provider usage endpoints when run; no account data, credentials or caches were collected, and those helpers were not run here. Remove `custom/ai-usage` from the bar if that module is unwanted.

Runtime dependencies include compatible Niri/Waybar, Kitty, Fuzzel, Mako, Hyprlock, swayidle, swaybg, wl-clipboard, Cliphist, gammastep, util-linux/flock, procps, coreutils, PipeWire/WirePlumber, playerctl, brightnessctl, Nautilus, Firefox, the polkit agent, gnome-keyring, udiskie, and JetBrainsMono Nerd Font. Panel controls additionally use Python/PyGObject, GTK 3, GtkLayerShell, NetworkManager tools, Blueman, PulseAudio-compatible tools and power-profiles-daemon. Super+Shift+Enter invokes the separately packaged `prettymux` (not included here).

Start with the shared `niri-session` wrapper and choose a [session backend](session/README.md). Systemd services are optional; the portable Awake variant uses elogind inhibition and Python. Install `desktop-power` and `desktop-polkit-agent` from [desktop/common](../common/README.md); choose a power profile and adapt the polkit agent through `POLKIT_AGENT` when needed. Keyboard repeat defaults are 250 ms / 45 Hz. `bin/displays` can report Niri outputs or fall back to DRM sysfs, but this snapshot does not automatically mirror the LG monitor through the Dell dock. Choose target output rules deliberately.

See [Niri keybinding differences](../../keybinds/README.md#niri-differences) and [source records](../../docs/sources.md). Run `niri validate -c /path/to/config.kdl` with a compatible Niri on the target; a compositor version is not pinned by the source repository.

The platform adapters were added on 2026-10-01 with shared settings retained; validation was skipped at the user's request.
