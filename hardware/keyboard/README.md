# External Gaming Keyboard

Current machine: `udev/hwdb.d/90-gentoo-external-keyboard.hwdb` maps left/right Alt to Meta and left/right Meta to Alt for USB `1fc9:e8c7` only. The laptop keyboard is unaffected by this rule. Target path is `/etc/udev/hwdb.d/90-gentoo-external-keyboard.hwdb`; applying a hwdb change requires rebuilding the target's hardware database and device reinitialization.

Alternative X11 implementation: `../x11/bin/workstation-keyboards` selects matching physical slave keyboards by XInput product ID `8137, 59591` and applies `altwin:swap_alt_win`. It reads `~/.config/workstation/keyboard.conf` and is rerun by the X11 hotplug helper. Example settings are under `../x11/config/workstation/`.

Alternative Wayland implementation: `../../desktop/hyprland/config/hypr/hyprland.lua` selects `gaming-keyboard` and `gaming-keyboard-1` devices. These names are compositor-specific.

Choose one remapping layer for this device. The desired semantic key is Super; the physical Command/Alt legends differ between keyboards. The x11 reference also documents the same device. Do not apply this quirk globally to other keyboards.

The Niri setup offers another alternative in `keyd/external-keyboard.conf`: keyd maps Alt/Meta layers for two capability-specific interfaces of USB `1fc9:e8c7`. The target is `/etc/keyd/external-keyboard.conf`, with the keyd daemon installed/enabled by the adopting machine. These interface hashes may differ on another device. Choose this instead of stacking it with the hwdb or compositor/XKB swap; Niri's KDL itself leaves keyboard XKB options unmodified. Source license: `../../desktop/niri/LICENSE`.
