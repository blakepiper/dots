# KDE Plasma and KWin

Current-machine snapshot: `config/` contains selected `~/.config` settings, `share/` contains custom assets from `~/.local/share`, and `bin/` contains the screenshot commands. Application history and restored sessions are excluded.

- `kwinrc`: five numbered desktops, Night Color at 3000 K, disabled animation effects, three enabled custom scripts, and captured per-output tile settings.
- `share/kwin/scripts/kde-tiling`: automatic recursive splits or master/stack, window cycling/swapping, floating toggle, adjustable first split. It removes decorations on tiled windows and uses its own layout state.
- `kde-focus-border`: the companion focused-window border. `kde-screenshot`: region screenshot shortcut via a session D-Bus service.
- `kdeglobals`: JetBrainsMono Nerd Font at 10 pt for general, menu and toolbar text, 8 pt for small text, and 10 pt bold for window titles; fixed-width text uses JetBrainsMono Nerd Font Mono at 10 pt. Font settings captured in `snapshot-05` on 2026-10-03.
- `plasmarc`, desktop applets and shell settings: dark appearance, wallpaper, transparent panel theme, panel layout, CPU/RAM widgets, and launcher icon. The custom theme and widgets are included under `share/plasma/`.
- `kglobalshortcutsrc`: actual captured assignments; compare the portable intent in `../../keybinds/README.md` before merging.
- `kcminputrc`, `kxkbrc`: cursor/input settings; device mappings are host-specific. Current KDE repeat delay/rate are 600 ms / 25 Hz.
- Lock-screen, session, notification, locale, and power files preserve the selected current preferences.

Dependencies: JetBrainsMono Nerd Font (including the Mono family), a compatible Plasma/KWin scripting and QML environment, Flameshot, Python with dbus-python/PyGObject, and a session D-Bus. Region capture runs Flameshot in Wayland mode and copies on selection. The D-Bus activation file points to `/home/przvl/.local/bin/screenshot-shortcut-service`; adapt that absolute path. Its Python implementation was changed only to resolve `screenshot-region` from the target user's home.

Wallpapers are in `../../walls/`. Display topology is in `../../hardware/monitor/kde/`, keyboard hwdb mapping in `../../hardware/keyboard/`, and Konsole in `../../terminal/konsole/`. Preserve target activity/desktop IDs when merging. The applet snapshot contains source containment IDs and absolute wallpaper/icon paths; use it as a layout reference.

Snapshot `snapshot-07` on 2026-10-03 refreshes the unchanged local applet file with the Kickoff popup width at 685 and adds selected `dolphinrc` preferences: hidden menu bar and fixed 22px Places icons. Dolphin's generated version/view timestamp fields are excluded. Both use the existing `config/` destination; the launcher retains captured containment IDs and an account-specific icon path, adapted below. Captured versions: Plasma 6.7.5 and Dolphin 26.04.3. No source commit is available; full provenance and prior capture hashes are in [sources.json](../../docs/sources.json).

| Collection file (after collection-03) | SHA-256 |
| --- | --- |
| `desktop/kde/config/plasma-org.kde.plasma.desktop-appletsrc` | `f49d35341d6997b284ef3cf069a23eca04c511cb7ea8d0337296d584b9dff846` |
| `desktop/kde/config/dolphinrc` | `a4787f79f8a9fef5bdd1643482af2257c5feb0a3f25302ba8e9947fac35da054` |

The changed configuration files parsed as INI; no Plasma or Dolphin settings were activated. Shared GTK font and Fontconfig preferences are documented in [desktop/common](../common/README.md).

## Deployment findings incorporated

`collection-03`, 2026-10-03, adapts this reference using reviewed `snapshot-08` findings. KWin script, widget and panel-theme IDs now describe their functions, with matching metadata/config/shortcut references. The screenshot bus is `org.local.Screenshot`; remove old registrations when migrating. The launcher uses the included blue Arch SVG, and the pager explicitly selects numeric indexes without window icons/outlines. The snapshot still retains original containment/activity/output IDs; recreate those on the target. Explicit top-left edge settings disable hover Overview while retaining keyboard shortcuts.

Additional dependencies: the matching Qt WebP decoder (`qt6-imageformats` in the observed Artix package set), KDE screenshot portal, installed Adwaita plus-crosshair cursor and Breeze fallback. The single `flameshot-session` wrapper supplies the environment to both CLI and D-Bus activation. Included cursor aliases reference the installed Adwaita asset rather than vendoring its binary. Both service Exec fields remain absolute target-account examples.

The selected local wrapper, Flameshot activation override, cursor index and launcher asset were reviewed before capture; no generated trees or runtime inventories were imported. The launcher SVG retains its artwork/trademark notice. All previous capture hashes, rename edits and current hashes are in [sources.json](../../docs/sources.json). [Activation recipes](activation.md) explain current-build launcher flags, effects, input, live fonts and screenshot evidence. No desktop settings were activated in this collection pass.

| Added/adapted collection file | SHA-256 |
| --- | --- |
| `desktop/kde/bin/flameshot-session` | `287c4c3ce907661697864f7fdbaa322091a092f6d50e4efe9bbceef00d80cd45` |
| `desktop/kde/share/dbus-1/services/org.flameshot.Flameshot.service` | `8b5f2940f8579f6970bcc3e09067703ca11ad35e7f8edcc4387877d872866201` |
| `desktop/kde/share/dbus-1/services/org.local.Screenshot.service` | `8db3b2283c4868722df0d222b9040fc7d1cadab11a559c97849a931ce728f7c5` |
| `desktop/kde/share/icons/archlinux-launcher.svg` | `db71ef7ee868dc2127c936252f55691b0f7db0ac997737c356fc91d93fcb670f` |
| `desktop/kde/share/icons/screenshot-crosshair/index.theme` | `b81b2c879ad1353aa22d7a56b632cb21555d2dd522adb105fa094f784c9cbaa2` |
