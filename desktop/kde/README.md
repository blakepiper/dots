# KDE Plasma and KWin

Current-machine snapshot: `config/` contains selected `~/.config` settings, `share/` contains custom assets from `~/.local/share`, and `bin/` contains the screenshot commands. Application history and restored sessions are excluded.

- `kwinrc`: five numbered desktops, Night Color at 3000 K, disabled animation effects, three enabled custom scripts, and captured per-output tile settings.
- `share/kwin/scripts/kde-tiling`: automatic recursive splits or master/stack, window cycling/swapping, floating toggle, adjustable first split. It removes decorations on tiled windows and uses its own layout state.
- `kde-focus-border`: the companion focused-window border. `kde-screenshot`: region screenshot shortcut via a session D-Bus service.
- `kdeglobals`: JetBrainsMono Nerd Font at 10 pt for general, menu and toolbar text, 8 pt for small text, and 10 pt bold for window titles; fixed-width text uses JetBrainsMono Nerd Font Mono at 10 pt. Font settings captured in `snapshot-05` on 2026-10-03.
- `plasmarc`, desktop applets and shell settings: dark appearance, wallpaper, solid black panel theme, panel layout, CPU/RAM widgets, and launcher icon. The custom theme and widgets are included under `share/plasma/`.
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

## Black topbar preference

`snapshot-09`, 2026-10-03, captures the user-confirmed solid black (`#000000`) topbar. The active local `plasma-black` theme is collected as `share/plasma/desktoptheme/panel-black/`, with matching metadata and `config/plasmarc`. This replaces the earlier transparent theme. The regular, opaque and translucent SVG variants use full-opacity black surfaces and masks, preserving geometry, margins, shadows and the existing panel layout. The theme retains its Breeze fallback and disabled adaptive transparency setting.

Install under the target user’s `~/.local/share/plasma/desktoptheme/panel-black/` and select `panel-black` as described in [activation.md](activation.md). Adapt the existing wallpaper path in `config/plasmarc` to the target. No local source commit is available; source/current hashes and previous captures are retained in [sources.json](../../docs/sources.json). JSON, INI, SVG geometry/opacity and manifest integrity were checked. The user confirmed the earlier live appearance; this collection update did not activate desktop settings.

| Collection file | SHA-256 |
| --- | --- |
| `desktop/kde/share/plasma/desktoptheme/panel-black/metadata.json` | `ab206c2151b6435b356c988251b9fef9f4a4cf2667613092434a986df8756a6b` |
| `desktop/kde/share/plasma/desktoptheme/panel-black/widgets/panel-background.svg` (also identical in `opaque/` and `translucent/`) | `6637e3db857b7b2326c7a296017bac949d208bc548a3b9f44edadb19c0ca864c` |

## Standalone Super preference

`snapshot-11`, 2026-10-04, carries the user-requested preference that pressing Super alone does not open the KDE application menu. In `config/kglobalshortcutsrc`, the active `plasmashell` application launcher shortcut is `Alt+F1`; the default field still records KDE's `Meta`/`Alt+F1` defaults. Super+Space continues to launch KRunner. Only this reviewed assignment was copied from the live file, preserving the collection's other adapted shortcuts and functional action IDs.

Observed KWin version: 6.7.5. No local source commit is available; the source hash, prior capture and collection hash are recorded in [sources.json](../../docs/sources.json). Live KGlobalAccel and saved-config readback confirmed Alt+F1 as the sole launcher shortcut before collection maintenance. INI, JSON and manifest hashes were checked; no desktop settings were activated during this collection update.

| Collection file | SHA-256 |
| --- | --- |
| `desktop/kde/config/kglobalshortcutsrc` | `6663bf08257153259cba678928c1724400baafb8231d6281a00eadf378dee629` |

## Window opacity preference

`snapshot-14`, 2026-10-04, refreshes `config/kwinrulesrc`: Firefox is fully opaque (100% opacity), while other active and inactive windows use 70% opacity (30% transparency). The Firefox rule precedes the catch-all rule in `[General] rules`, and both rules force their active/inactive values. This supersedes the all-window transparency preference from `snapshot-13`.

Merge these rules into the target user's `~/.config/kwinrulesrc`, preserving the Firefox-first order and adapting the `firefox` window class if the installed browser uses a different class. Retain unrelated target rules and update the rule list/count when merging. KWin on the target must support these KConfig rule fields; the current collection records the observed Plasma 6 environment. During an authorized deployment, reload with `qdbus6 org.kde.KWin /KWin org.kde.KWin.reconfigure`.

No local source commit is available; source and collection hashes are in [sources.json](../../docs/sources.json). The authorized live change was reconfigured and saved values read back as 100% for Firefox and 70% for other active/inactive windows. Collection INI, Firefox-first rule list/count, JSON and hashes were checked separately.

| Collection file | SHA-256 |
| --- | --- |
| `desktop/kde/config/kwinrulesrc` | `7f93f77f83e56b394ff283e19d2760957fb9b9decd86125a7df28d4526a83987` |

## Topbar tray preference

`snapshot-13` also carries the tray settings into `config/plasma-org.kde.plasma.desktop-appletsrc`. Only network, brightness and volume widgets are enabled; Bluetooth and other unused tray widgets are disabled. `showAllItems=true` and empty hidden/shown lists keep the remaining controls visible and remove the hidden-icons chevron. The separate battery widget remains in the panel. Future application tray icons can also appear directly in the bar.

Only the tray's `General` settings were copied from the live configuration. The collection retains its containment/applet IDs, widget order, functional widget IDs and wallpaper/icon paths. When merging, find the target system-tray applet rather than assuming containment `22` and applet `27`. The known-items list records disabled widgets so they are not automatically treated as new additions. Observed Plasma version: 6.7.5. Live before/after screenshots confirmed the Bluetooth icon and chevron were removed while the other visible controls remained.

| Collection file | SHA-256 |
| --- | --- |
| `desktop/kde/config/plasma-org.kde.plasma.desktop-appletsrc` | `26fa6b0c23be951022c68eed387cba5977a572c2ec6cf91b9d8e4a4d4e72de84` |

## Firefox private-window shortcut

`snapshot-16`, 2026-10-04, adds `new-private-window=Meta+Shift+B` under `[services][firefox.desktop]` in `config/kglobalshortcutsrc`. Super+Shift+B opens a Firefox private browsing window; Super+B remains the normal browser launcher. Only this reviewed assignment was merged from the live file, retaining the collection's other shortcuts and functional action IDs.

The installed Firefox desktop entry must provide the `new-private-window` action; adapt `firefox.desktop` if the target uses another desktop-file ID. The observed entry executes Firefox with `--private-window`. KGlobalAccel reported no conflict and read back the assigned chord; dispatching the action opened a window showing Firefox's private-browsing page. Physical keyboard activation was not simulated. INI, JSON and capture hashes were checked without reactivating desktop settings during collection maintenance. Source and previous capture hashes are in [sources.json](../../docs/sources.json).

| Collection file | SHA-256 |
| --- | --- |
| `desktop/kde/config/kglobalshortcutsrc` | `be2caafce59d33f67aa094b8b675b829bfc1660703db728d4a15e95511368c99` |
