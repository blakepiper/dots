# Ghostty

Merge `config/config` into `~/.config/ghostty/config`. It uses Bash through PATH, JetBrainsMono Nerd Font and the captured Tokyo Night palette. Install the font and use the shared [Bash settings](../../shell/bash/README.md) if desired. Both configs passed Ghostty 1.4.0's configuration validator.

The [Hyprland terminal helper](../../desktop/hyprland/bin/workstation-hyprland-terminal) also reads `config/glass.conf` from the same destination directory. The overlay sets background alpha and padding. Hyprland applies the glass material to the helper's distinct `org.local.GhosttyGlass` application ID, with text at full opacity. Set `HYPRLAND_TERMINAL_FONT_SIZE=15` before starting Hyprland and install Terminus (TTF) for the captured laptop's larger bitmap-style text. Other Ghostty sessions use the shared font settings.

Snapshot `snapshot-29`, 2026-11-17, extracts the shared settings and session-specific overlay from the captured Ghostty and Hyprland modules. The source license notice is included in `iglass-LICENSE`. See [source records](../../docs/sources.json) for the commit, hashes and adaptations.
