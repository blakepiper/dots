# Snapshot records

Collected on 2026-10-01 from the current machine and four source snapshots. Origin project names and URLs are omitted. Snapshot IDs in [sources.json](sources.json) retain capture commit IDs, original file hashes, current file hashes and known edits without exposing the original repository names. Local source paths are retained where useful.

| Snapshot | Material |
| --- | --- |
| snapshot-01 | OXWM, shared X11 session/helpers, display/input examples, Firefox policies |
| snapshot-02 | Hyprland Lua/session helpers and application settings, host display options, tmux |
| snapshot-03 | Alternate X11 keyboard/display hotplug examples and st customization |
| snapshot-04 | Niri, bar/panel helpers, Kitty, mountain wallpaper and keyd mapping |
| Local machine | KDE/SDDM/Neovim, wallpapers, Konsole, input and power rules, shell fragment |
| snapshot-06 | Local Firefox interface CSS and explicit preferences, captured 2026-10-03 |
| snapshot-07 | Local Konsole font, Plasma launcher/display refresh, GTK/Fontconfig and Dolphin settings, captured 2026-10-03 |
| snapshot-09 | User-confirmed solid black KDE topbar theme and preference, captured 2026-10-03 |

Names in the collection describe the application, platform or function. Hyprland's helper and service names use `workstation`; Niri helpers use `desktop` for cache and application identifiers. The st shell wrapper is `st-shell`. Alternate X11 hardware files use `x11` names. References and dependent command paths were updated together.

The KDE screenshot service resolves its helper relative to the target home. Bash and X11 hardware settings include documented extracts. The X11 session PATH uses the user's local bin plus the inherited system PATH; authentication still requires a target-appropriate privileged locker. Platform-specific Scheme references were replaced by the reusable shell examples and [OXWM build notes](../desktop/oxwm/reference/build.md).

Imported license and copyright notices remain intact. The st license is under `terminal/st/`; the Niri material's source license is under `desktop/niri/`. The clipboard watcher retains its MIT SPDX notice. No blanket license or image authorship was invented for the collection. Wallpaper-specific rights remain unestablished by these filenames.

No credentials, browser accounts, usage caches, shell histories, restored sessions, downloaded plugin trees or installer backups were collected. No machine settings were activated.

Collection reorganization on 2026-10-01 groups desktops and SDDM under `desktop/` and moves shared Bash to `shell/bash/`. Hyprland Nix modules and their lock were replaced with plain Lua, Bash, application configs and systemd user units derived from snapshot-02. Hardware display values are in `hardware/hyprland/`; Foot settings are in `terminal/foot/`. The custom workspace buttons replace the Waybar source patch. Validation was skipped at the user's request.

A subsequent platform pass on 2026-10-01 isolates Hyprland user units from shared configs, adds a portable session supervisor, separates Niri Awake inhibition backends, introduces shared configurable power commands, factors battery activation into shared behavior plus OpenRC/systemd/udev adapters, makes the X11 locker path configurable, and relocates optional tmux Nix packaging. Niri network detection now queries NetworkManager directly rather than systemctl. Captured implementations remain where they are meaningful alternatives. No account/service/hardware helpers were run and validation was skipped.

Firefox capture on 2026-10-03 (`snapshot-06`) preserves the local `userChrome.css` unchanged and the reviewed `user.js` with four appearance preferences extracted from saved settings. The generated `prefs.js`, extension packages and browser data are excluded. Firefox 157.0 and target profile adaptation are documented in [browser](../browser/README.md). JavaScript syntax/literal settings, JSON records and hashes were checked; no Firefox runtime or visual check was performed.

Desktop appearance capture on 2026-10-03 (`snapshot-07`) updates Konsole to JetBrainsMono Nerd Font Mono at 9 pt, the saved external display to 120 Hz, and the Kickoff popup width to 685. Identical GTK 3/4 font settings share one file; Fontconfig retains its layout and rules with trailing whitespace trimmed in `fonts.conf`. Dolphin contains only menu/icon preferences, excluding generated version/view timestamps. Previous records remain in `previous_captures` for refreshed files. JSON, INI, XML and hashes were checked, and existing live display/font selections were queried read-only. No machine settings were activated.

`snapshot-08`, reviewed 2026-10-03, records the local lessons report (base capture commit `8018235c39e01d686b9c1050ff6448ed78040075`) and selected local Flameshot/cursor/launcher, keyboard and dinit adapters plus neofetch settings. The report’s SHA-256 is recorded without importing its full machine inventory or temporary scripts. The user subsequently confirmed audio works; microphone and other pending persistence/login checks remain distinct. `collection-03` applies final preferences, functional runtime names, narrow adapters, preflight/activation/rollback guidance and dependency/update-ownership notes. Shared configs/helpers remain single copies. Records retain previous captures for modified/moved files; cursor symlinks hash their literal targets and do not import system cursor binaries. No source commit exists for the local deployment files. No machine settings were activated.

`snapshot-09`, captured 2026-10-03 against base commit `958a649cf8d44c0ad7e17e1b3124a3555f3768bc`, replaces the KDE transparent panel theme with the user-confirmed solid black topbar. Selected local `plasma-black` assets are adapted to the functional `panel-black` ID, with matching metadata and theme selection. SVG variants preserve geometry and margins while making panel surfaces and masks opaque black. The existing collected wallpaper reference and panel layout are retained. Previous captures and source/current hashes remain in `sources.json`. JSON, INI, SVG geometry/opacity and hashes were checked; no machine settings were activated during collection maintenance.
