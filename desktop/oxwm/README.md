# OXWM

`config.lua` defines the desktop; `bin/oxwm-{battery,cpu}` supply its status blocks. It targets OXWM 0.13.0, upstream commit `fc4ada9ac4ee8e34ace203290a2b14d10e4671cc`. `patches/` contains the microphone keysym, unique mirrored-screen and equal-split patches in numerical application order. [Build notes](reference/build.md) record source hash and build inputs.

Behavior: nine tags, dwindle by default, no gaps, two-pixel borders, opaque colors and a status bar. An optional `~/.config/oxwm/bar-font` overrides the bar font. Terminal launch requests `st -f monospace:size=14 -e bash`.

Config destination: `~/.config/oxwm/config.lua`. Helpers belong on PATH. Bindings expect st, dmenu, Xfe, Firefox, wpctl, playerctl, and commands in `../x11/bin/` and `../../hardware/x11/bin/`. Battery status depends on `WORKSTATION_BATTERY`, initialized by the included X session. Session/compositor/clipboard material lives in [desktop/x11](../x11/README.md), display/input policies in [hardware](../../hardware/README.md). This is reference material, not a built or activated WM.
