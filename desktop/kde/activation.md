# KDE activation and evidence

These are target-deployment recipes, not an installer. Begin with [read-only preflight](../../docs/validation.md), back up selected files, adapt paths/IDs, and activate only within the target deployment's authorization. `snapshot-08` records the 2026-10-03 observations; numeric API flags/enums are version-specific.

## Launchers

Inspect the session bus with `qdbus6 org.kde.kglobalaccel /kglobalaccel` and `qdbus6 org.kde.KWin /Effects`. Discover component paths/method signatures from introspection rather than constructing them from guessed names. KGlobalAccel needs the actual desktop-file component and `_launch` action; a component can be active because a different action is registered. Adapt `firefox.desktop`, Konsole, Dolphin and KRunner desktop IDs to files installed on the target. Do not skip every underscore-prefixed action: only `_k_friendly_name` is metadata in the captured assignment file.

For an authorized launcher repair using Python dbus-python, the observed API sequence was:

```python
import dbus
bus = dbus.SessionBus()
accel = dbus.Interface(bus.get_object('org.kde.kglobalaccel', '/kglobalaccel'),
                       'org.kde.KGlobalAccel')
action = dbus.Array(['firefox.desktop', '_launch', 'Firefox', 'Launch Firefox'],
                    signature='s')
# Qt's QKeySequence('Meta+B').toCombined() supplied this value on the observed build.
# Convert chords with the target Qt runtime; do not parse shifted symbols by hand.
keys = dbus.Array([0x10000042], signature='i')
accel.doRegister(action)
accel.setShortcut(action, dbus.Array([], signature='i'), dbus.UInt32(6))
accel.setShortcut(action, keys, dbus.UInt32(6))
assert list(accel.shortcut(action)) == list(keys)
```

Here `6` is `SetPresent | NoAutoloading` (`2 | 4`) on the observed build. Verify current flags before use. Custom KWin actions are registered by their scripts; their chord synchronization differs from desktop launchers (the deployment used `setForeignShortcut`). Readback proves registration, then test physical Super+B and observe the resulting Firefox window. Keep input-event injection out of ordinary collection checks. Test conflicts/reserved keys separately, including task-manager number bindings.

## Panel, effects and wallpaper

Recreate the panel through Plasma's target API, associating discovered activity/output IDs. The snapshot's nine roles are launcher, numeric pager, separator, spacer, RAM, CPU, battery, system tray and clock. Use 20px height and 685px launcher popup width. Install the included packages under their functional IDs: `kde-tiling`, `kde-focus-border`, `kde-screenshot`, `panel-black`, `local.plasma.cpu`, `local.plasma.ram`. When migrating an older deployment, remove its old registrations rather than enabling duplicate scripts/widgets; shortcut names now use `KDE`.

The preferred topbar background is solid black (`#000000`) with full opacity, captured in `snapshot-09`. Install `share/plasma/desktoptheme/panel-black/` under `~/.local/share/plasma/desktoptheme/panel-black/`, then select it with `plasma-apply-desktoptheme panel-black` during an authorized deployment. The local confirmed theme was named `plasma-black`; the collection uses `panel-black` consistently in metadata and `config/plasmarc`. All three panel SVG variants render black so the panel opacity mode does not restore transparency. Other surfaces fall back to Breeze; panel geometry and widget order are retained.

On Plasma 6.7.5, pager `displayedText=0` selected indexes; `showWindowIcons=false` and `showWindowOutlines=false` retained plain numbers. Preserve five desktops named 1–5 and the target UUIDs. Enum meanings must be checked on other versions.

After saving disabled Slide/Scale flags, inspect `/Effects` for loaded and active effects. In an authorized deployment, unload each through the introspected `org.kde.kwin.Effects.unloadEffect` method, reconfigure KWin, then inspect while actually switching desktops. Missing activity at idle alone is not evidence that a transition is disabled.

The unwanted launcher hover was the default top-left Overview edge. `[Effect-overview] BorderActivate=9` (`ElectricNone` on the observed build) and `[ElectricBorders] TopLeft=None`, followed by KWin/Overview reconfiguration, removed the edge without removing keyboard Overview/Grid. Confirm with actual pointer hover.

Install a Qt WebP decoder matching the runtime before selecting `cityview.webp`. Merge target absolute `file:///...` URIs for desktop/locker, clear any transient wallpaper `PreviewImage` through the target wallpaper API (`null` in the observed live repair), and inspect rendered results. If a QML settings page fails with private-symbol errors, compare installed and mapped Qt versions before editing more config. Refreshing Plasma loads new libraries for the shell; it does not restart KWin or prove every session process is current.

## Fonts, profiles and input

Inspect `fc-match` first, then the affected live process. GTK 3/4 share one [settings source](../common/README.md), but desktop GSettings font/monospace values may also need alignment through the existing settings service. Konsole can cache profile availability: open a fresh terminal explicitly with `konsole --profile Classic`, check the selected profile, and verify a normal fresh terminal uses the default. If preserving an existing terminal, introspect its session API before changing the live profile; the deployment loaded the new profile through a temporary tab. Do not close working terminals to prove a font choice.

Enumerate KWin's libinput objects/capabilities over session D-Bus. For every interface supporting natural scrolling, set its `org.kde.KWin.InputDevice` `naturalScroll` property when authorized and persist `NaturalScroll=true` in `kcminputrc` under the discovered vendor/product/name group. Reconfigure, read back and test physically. Do not copy event IDs or silently apply source groups to different hardware. The six observed interfaces belonged to the Logitech G502 HERO, the ASUS touchpad/compatibility mouse, and two scrolling interfaces of USB `1fc9:e8c7`.

## Screenshot activation

Deploy the selected `bin/` commands to `~/.local/bin/` and `share/` assets to `~/.local/share/`, adapting both D-Bus service Exec paths. `kde-screenshot` calls `org.local.Screenshot`; its Python service resolves the region helper from the target home. `screenshot-region` and the per-user `org.flameshot.Flameshot.service` use the single `flameshot-session` environment wrapper. The binary path `/usr/bin/flameshot` is a package-layout assumption.

The cursor theme contains symlink aliases to the installed Adwaita plus crosshair and inherits Breeze for other shapes; install both themes and adapt the absolute Adwaita cursor path if needed. Cursor binaries are not vendored. `QT_WAYLAND_DISABLED_INTERFACES=wp_cursor_shape_manager_v1` bypasses compositor cursor-shape substitution for Flameshot only. `QT_QPA_PLATFORMTHEME=generic` and `XCURSOR_THEME=screenshot-crosshair` are scoped to its renderer, not the global session.

Existing Flameshot daemons will keep their old environment until restarted through the target's existing activation mechanism. Inspect the actual daemon environment, portal versions and service bus. A stale KDE portal after package replacement caused authorization failures in deployment; restart only the affected process when justified. Verify an actual selected region reaches the clipboard as PNG; the observed capture was 240×120. Dispatch alone does not prove capture or cursor appearance.
