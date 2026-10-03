# LG external monitor

`kde/kwinoutputconfig.json` is the current machine's exact `~/.config/kwinoutputconfig.json` snapshot. It identifies the external display through a GSM EDID identifier on `DP-7` with an MST path; it contains EDID hashes/output UUIDs and source display configurations. The saved external mode is 1920×1080 at 120 Hz, scale 1.5; the saved internal mode is 1920×1080 at approximately 60 Hz, scale 1.5. The EDID data does not establish a precise retail model name here.

The captured display notes describe a 2560×1440 external monitor capable of up to 144 Hz; its chosen mirrored policy uses 1920×1080, 60 Hz internal / 120 Hz external, and 1920×1200 at 60 Hz undocked. `../x11/bin/workstation-monitors` discovers connectors when explicit names do not match, handles disconnects, and refreshes the wallpaper after layout changes. Its settings are in `../x11/config/workstation/display.conf`.

These are saved preferences and source facts; the refresh was also checked against the running outputs on the capture machine. Set a target-specific mode/scale using that machine's detected capabilities and adapt output identifiers. Related KWin per-desktop tile groups remain in `../../desktop/kde/config/kwinrc`.

Refreshed unchanged from the local file in `snapshot-07` on 2026-10-03, with Plasma 6.7.5; no source commit is available. JSON syntax and source/current hashes were checked. A read-only `kscreen-doctor -o` query confirmed `DP-7` at 1920×1080, 120 Hz and `eDP-1` at 1920×1080, approximately 60 Hz, both at scale 1.5 on the capture machine. No display settings were activated. Full source and previous-capture hashes are in [sources.json](../../docs/sources.json).

| Collection file | SHA-256 |
| --- | --- |
| `hardware/monitor/kde/kwinoutputconfig.json` | `1a46d2fd28039952fe54193d28faa8440293a63c3e998d19c8ffc16c2c0dc99b` |
