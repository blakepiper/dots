# Adapting a module

Read its README and inspect the actual files first. Config trees indicate destination layout, not an instruction to overwrite an existing tree. Merge the settings you want and keep a copy of the target's existing files.

- `desktop/kde/config/` maps to `~/.config/`, `desktop/kde/share/` to `~/.local/share/`, and module `bin/` directories to `~/.local/bin/` when those helpers are chosen. `nvim/config/` maps to `~/.config/nvim/`.
- KDE wallpaper and icon settings and the screenshot D-Bus service retain `/home/przvl` paths. Replace them with the target's absolute paths. KDE config and D-Bus `Exec` do not perform shell `$HOME` expansion. The Python screenshot service itself resolves the target home dynamically.
- KDE activity, desktop, containment, output, and device IDs reflect the source machine. The display snapshot is under `hardware/monitor/kde/`; create or adapt output settings on the target rather than transplanting IDs. KWin's `[Tiling]` groups likewise refer to source outputs/desktops.
- SDDM config files map to `/etc/sddm.conf.d/`; the selected theme maps to `/usr/share/sddm/themes/gentoo-minimal/`. Adapt the username and ensure the target provides a suitable Qt/SDDM runtime. Collection work does not change the running greeter.
- The external keyboard hwdb mapping and XKB Alt/Super swap are alternative layers implementing the same preference. Applying both to the same keyboard can undo the desired swap. Choose the layer appropriate to the target session.
- `hardware/x11/bin/` helpers read `~/.config/workstation/{display,keyboard,pointer}.conf`. Examples are included alongside them. These shell configs execute code when sourced; inspect them before using them.
- Choose X11's [locker layout](../desktop/x11/session/README.md) and target sleep/lock integration. Hyprland offers [systemd or portable session backends](../desktop/hyprland/session/README.md) over the same PATH-resolved helpers.
- Install dependencies intentionally. LazyVim bootstraps plugins when launched; `nvimide` expects Snacks, and one of its terminals runs `neofetch`. Fonts differ by module: JetBrainsMono Nerd Font Mono for current Konsole, DejaVu Sans Mono for OXWM, and JetBrainsMono Nerd Font for the Wayland tools.

No caches, browser/SSH accounts, command histories, or restored sessions are part of this collection. Wallpaper authorship and licensing are not established by the filenames; source records do not grant redistribution rights.

For [Niri](../desktop/niri/README.md), merge the KDL and companion configs independently. Its bar starts optional custom helpers, its locker uses Hyprlock, and its external keyboard example uses keyd; choose one remapping layer. Niri's output examples are disabled by default and do not implement the X11/Hyprland mirror policy. Choose a [session/Awake backend](../desktop/niri/session/README.md) and adapt the shared polkit/power integration to the target.

All terminal choices share [Bash with ble.sh](../shell/bash/README.md). Install ble.sh and merge the common rcfile fragment on every adopting machine; an absent ble.sh installation leaves that preference incomplete.

Choose platform adapters at the [documented boundaries](platforms.md). Shared desktop power menus require a selected trusted Bash profile; copying all alternative service trees together is not an adoption procedure.

For [Firefox](../browser/README.md), merge `browser/firefox/user.js` and `browser/firefox/chrome/userChrome.css` into the target profile root and its `chrome/` directory. Obtain that root from `about:profiles`; the captured username and generated profile name are machine-specific. The profile preferences include behavioral privacy choices as well as appearance, and the enterprise policy file has a separate installation-wide destination.

Shared [GTK and Fontconfig settings](../desktop/common/README.md) are independent of the desktop session. Merge the single GTK settings source into both GTK 3 and GTK 4 settings files and preserve the Fontconfig `conf.d/` layout. Install the named font families separately. The selected Dolphin preferences map to `~/.config/dolphinrc`; generated view timestamps are omitted.
