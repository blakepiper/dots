# KDE Plasma and KWin

Current-machine snapshot: `config/` contains selected `~/.config` settings, `share/` contains custom assets from `~/.local/share`, and `bin/` contains the screenshot commands. Application history and restored sessions are excluded.

- `kwinrc`: five numbered desktops, Night Color at 3000 K, disabled animation effects, three enabled custom scripts, and captured per-output tile settings.
- `share/kwin/scripts/gentoo-tiling`: automatic recursive splits or master/stack, window cycling/swapping, floating toggle, adjustable first split. It removes decorations on tiled windows and uses its own layout state.
- `gentoo-focus-border`: the companion focused-window border. `gentoo-screenshot`: region screenshot shortcut via a session D-Bus service.
- `kdeglobals`: JetBrainsMono Nerd Font at 10 pt for general, menu and toolbar text, 8 pt for small text, and 10 pt bold for window titles; fixed-width text uses JetBrainsMono Nerd Font Mono at 10 pt. Font settings captured in `snapshot-05` on 2026-10-03.
- `plasmarc`, desktop applets and shell settings: dark appearance, wallpaper, transparent panel theme, panel layout, CPU/RAM widgets, and launcher icon. The custom theme and widgets are included under `share/plasma/`.
- `kglobalshortcutsrc`: actual captured assignments; compare the portable intent in `../../keybinds/README.md` before merging.
- `kcminputrc`, `kxkbrc`: cursor/input settings; device mappings are host-specific. Current KDE repeat delay/rate are 600 ms / 25 Hz.
- Lock-screen, session, notification, locale, and power files preserve the selected current preferences.

Dependencies: JetBrainsMono Nerd Font (including the Mono family), a compatible Plasma/KWin scripting and QML environment, Flameshot, Python with dbus-python/PyGObject, and a session D-Bus. Region capture runs Flameshot in Wayland mode and copies on selection. The D-Bus activation file points to `/home/przvl/.local/bin/screenshot-shortcut-service`; adapt that absolute path. Its Python implementation was changed only to resolve `screenshot-region` from the target user's home.

Wallpapers are in `../../walls/`. Display topology is in `../../hardware/monitor/kde/`, keyboard hwdb mapping in `../../hardware/keyboard/`, and Konsole in `../../terminal/konsole/`. Preserve target activity/desktop IDs when merging. The applet snapshot contains source containment IDs and absolute wallpaper/icon paths; use it as a layout reference.

Snapshot `snapshot-07` on 2026-10-03 refreshes the unchanged local applet file with the Kickoff popup width at 685 and adds selected `dolphinrc` preferences: hidden menu bar and fixed 22px Places icons. Dolphin's generated version/view timestamp fields are excluded. Both use the existing `config/` destination; the launcher retains the captured containment IDs and account-specific icon path. Captured versions: Plasma 6.7.5 and Dolphin 26.04.3. No source commit is available; full provenance and prior capture hashes are in [sources.json](../../docs/sources.json).

| Collection file | SHA-256 |
| --- | --- |
| `desktop/kde/config/plasma-org.kde.plasma.desktop-appletsrc` | `4b4bf339adab54b7f264b5d27e9f3df72e8d9cfca75fbcbb7dd8eb7d717b537b` |
| `desktop/kde/config/dolphinrc` | `a4787f79f8a9fef5bdd1643482af2257c5feb0a3f25302ba8e9947fac35da054` |

The changed configuration files parsed as INI; no Plasma or Dolphin settings were activated. Shared GTK font and Fontconfig preferences are documented in [desktop/common](../common/README.md).
