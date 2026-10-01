# KDE Plasma and KWin

Current-machine snapshot: `config/` contains selected `~/.config` settings, `share/` contains custom assets from `~/.local/share`, and `bin/` contains the screenshot commands. Application history and restored sessions are excluded.

- `kwinrc`: five numbered desktops, Night Color at 3000 K, disabled animation effects, three enabled custom scripts, and captured per-output tile settings.
- `share/kwin/scripts/gentoo-tiling`: automatic recursive splits or master/stack, window cycling/swapping, floating toggle, adjustable first split. It removes decorations on tiled windows and uses its own layout state.
- `gentoo-focus-border`: the companion focused-window border. `gentoo-screenshot`: region screenshot shortcut via a session D-Bus service.
- `kdeglobals`, `plasmarc`, desktop applets and shell settings: dark appearance, wallpaper, transparent panel theme, panel layout, CPU/RAM widgets, and launcher icon. The custom theme and widgets are included under `share/plasma/`.
- `kglobalshortcutsrc`: actual captured assignments; compare the portable intent in `../../keybinds/README.md` before merging.
- `kcminputrc`, `kxkbrc`: cursor/input settings; device mappings are host-specific. Current KDE repeat delay/rate are 600 ms / 25 Hz.
- Lock-screen, session, notification, locale, and power files preserve the selected current preferences.

Dependencies: a compatible Plasma/KWin scripting and QML environment, Flameshot, Python with dbus-python/PyGObject, and a session D-Bus. Region capture runs Flameshot in Wayland mode and copies on selection. The D-Bus activation file points to `/home/przvl/.local/bin/screenshot-shortcut-service`; adapt that absolute path. Its Python implementation was changed only to resolve `screenshot-region` from the target user's home.

Wallpapers are in `../../walls/`. Display topology is in `../../hardware/monitor/kde/`, keyboard hwdb mapping in `../../hardware/keyboard/`, and Konsole in `../../terminal/konsole/`. Preserve target activity/desktop IDs when merging. The applet snapshot contains source containment IDs and absolute wallpaper/icon paths; use it as a layout reference.
