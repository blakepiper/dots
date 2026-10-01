# LG external monitor

`kde/kwinoutputconfig.json` is the current machine's exact `~/.config/kwinoutputconfig.json` snapshot. It identifies the external display through a GSM EDID identifier on `DP-7` with an MST path; it contains EDID hashes/output UUIDs and source display configurations. The saved external mode is 1920×1080 at 60 Hz, scale 1.5; the saved internal mode is 1920×1080 at approximately 60 Hz, scale 1.5. The EDID data does not establish a precise retail model name here.

The captured display notes describe a 2560×1440 external monitor capable of up to 144 Hz; its chosen mirrored policy uses 1920×1080, 60 Hz internal / 120 Hz external, and 1920×1200 at 60 Hz undocked. `../x11/bin/workstation-monitors` discovers connectors when explicit names do not match, handles disconnects, and refreshes the wallpaper after layout changes. Its settings are in `../x11/config/workstation/display.conf`.

These are saved preferences and historical source facts, not a fresh capability probe. Set a target-specific mode/scale using that machine's detected capabilities and adapt output identifiers. Related KWin per-desktop tile groups remain in `../../desktop/kde/config/kwinrc`.
