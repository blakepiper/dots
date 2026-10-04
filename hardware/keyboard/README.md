# External Gaming Keyboard

Current machine: `udev/hwdb.d/90-external-keyboard.hwdb` maps left/right Alt to Meta and left/right Meta to Alt for USB `1fc9:e8c7` only. The laptop keyboard is unaffected by this rule. Target path is `/etc/udev/hwdb.d/90-external-keyboard.hwdb`; applying a hwdb change requires rebuilding the target's hardware database and device reinitialization.

Alternative X11 implementation: `../x11/bin/workstation-keyboards` selects matching physical slave keyboards by XInput product ID `8137, 59591` and applies `altwin:swap_alt_win`. It reads `~/.config/workstation/keyboard.conf` and is rerun by the X11 hotplug helper. Example settings are under `../x11/config/workstation/`.

Alternative Wayland implementation: `../../desktop/hyprland/config/hypr/hyprland.lua` selects `gaming-keyboard` and `gaming-keyboard-1` devices. These names are compositor-specific.

Choose one remapping layer for this device. The desired semantic key is Super; the physical Command/Alt legends differ between keyboards. The x11 reference also documents the same device. Do not apply this quirk globally to other keyboards.

The Niri setup offers another alternative in `keyd/external-keyboard.conf`: keyd maps Alt/Meta layers for two capability-specific interfaces of USB `1fc9:e8c7`. The target is `/etc/keyd/external-keyboard.conf`, with the keyd daemon installed/enabled by the adopting machine. These interface hashes may differ on another device. Choose this instead of stacking it with the hwdb or compositor/XKB swap; Niri's KDL itself leaves keyboard XKB options unmodified. Source license: `../../desktop/niri/LICENSE`.

## Duplicate HID compatibility adapter

The Artix deployment found duplicate modifier usages: matching hwdb properties and one direct keycode lookup did not prove every alias was changed. `bin/external-keyboard-remap` enumerates indexed Linux `EVIOCGKEYCODE_V2` / `EVIOCSKEYCODE_V2` entries and applies **the existing hwdb properties** to every matching modifier slot. It is an adapter to that mapping source, not another remapping layer. The helper validates the USB modalias and is intended for Linux x86_64; its ioctl constants/struct layout must be reviewed for other ABIs. It requires Python 3.9+ and udevadm, with permission to modify the input keymap.

Map the helper to `/usr/local/libexec/external-keyboard-remap` and the narrowly matched `udev/rules.d/90-external-keyboard.rules` to `/etc/udev/rules.d/`. The rule matches USB `1fc9:e8c7` keyboard interfaces on add/change; transient event numbers are supplied by udev. Rebuild the target hwdb and reinitialize only the discovered matching interfaces when deployment is authorized. Do not also enable keyd or an XKB/compositor swap for this device. Verify all duplicate slots and actual key events, then replug/boot persistence; built-in AT keyboard codes must stay unchanged. Missing uinput for a stale running kernel is not grounds to change the init system.

Snapshot `snapshot-08`, 2026-10-03: reviewed local helper and rule, with no source commit. The helper was reformatted and made to reject malformed event paths and zero matching modifier slots; the rule is unchanged. The existing hwdb was renamed to a functional filename without changing its mapping. `collection-03` records adaptations and all hashes in [sources.json](../../docs/sources.json). No input mapping was applied from this collection.

| Added/adapted collection file | SHA-256 |
| --- | --- |
| `hardware/keyboard/bin/external-keyboard-remap` | `4403f64f724de8f4ab676e5697aca38b26400517a012b7c712bb4a81310801a8` |
| `hardware/keyboard/udev/rules.d/90-external-keyboard.rules` | `61acff9a8804bbe5a11d79631a20077d7cc703d105ad5fc36183fe7f0d744f7b` |
| `hardware/keyboard/udev/hwdb.d/90-external-keyboard.hwdb` | `e113b07bff14d1b363983cd1ea4fedbab7717f183572724728ff8b19556cb317` |
