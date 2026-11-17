# Dell dock and display hotplug

No dedicated Dell-specific driver override, firmware setting, or independently identified dock model was found in the selected machine configs or source repositories. The relevant existing material is display and input reconnection handling:

- `../x11/bin/workstation-hotplug` listens to udev DRM/input events and reruns monitor/keyboard/pointer helpers.
- `../x11/bin/workstation-monitors` discovers connected eDP and HDMI/DP outputs, so changing MST connector suffixes do not require a fixed dock port name.
- The [Hyprland hardware example](../hyprland/config/workstation/hyprland-display.lua) identifies the internal connector. With that example adapted, the [Hyprland configuration](../../desktop/hyprland/README.md) mirrors a dynamically discovered external output at its preferred mode and restores the internal panel when unplugged.
- `../monitor/kde/kwinoutputconfig.json` preserves the current saved DP/MST topology. The older x11 reference assumes a fixed `HDMI-2` connector.

The captured behavior is reusable for docking but does not prove a particular Dell model or require a Dell vendor quirk. Thunderbolt authorization, dock firmware and USB/audio/network behavior need their own evidence before adding device-specific settings.
