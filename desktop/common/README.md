# Shared desktop integration

Shared GTK and Fontconfig preferences live here; desktop-specific settings stay with their desktop. The small helpers cover shared platform boundaries without requiring copies of application settings. Added 2026-10-01; source records are in [sources.json](../../docs/sources.json).

Put selected `bin/` helpers on PATH. X11, Hyprland and Niri control menus use `desktop-power`. Choose **one** profile from `power/systemd/`, `power/elogind/`, or `power/portable/`, and merge it into `~/.config/workstation/power.conf`. `DESKTOP_POWER_CONFIG` can select another absolute path. Profiles are trusted Bash code containing command arrays; inspect them before use.

The systemd profile invokes systemctl. The elogind profile uses elogind's loginctl power verbs; systemd's loginctl does not provide those same power commands. The portable profile illustrates direct platform tools (`zzz` and `shutdown`) and requires adapting command availability, flags and authorization. Missing configuration is an error rather than an automatic choice of a power manager. Session managers, lockers and platform sleep hooks remain responsible for lock-before-suspend integration.

Niri also uses `desktop-polkit-agent`. It recognizes common KDE/GNOME authentication agent installation paths. Set `POLKIT_AGENT` in the session environment to an absolute executable path on another layout. This helper starts an agent, not a polkit system service.

D-Bus, logind/elogind, PAM, udev and application daemons are distinct dependencies. A portable session supervisor removes dependence on systemd **service management**; it does not provide authentication, portals, device discovery or sleep inhibition itself.

## Shared fonts and GTK settings

`config/gtk/settings.ini` is the single shared source for `~/.config/gtk-3.0/settings.ini` and `~/.config/gtk-4.0/settings.ini`: merge its `gtk-font-name` value into both target files. It selects JetBrainsMono Nerd Font at 10 pt. GTK 3 and GTK 4 had identical files on the captured machine; this collection stores one copy.

`config/fontconfig/` maps to `~/.config/fontconfig/`, preserving `fonts.conf` and `conf.d/99-jetbrains-mono.conf`. The alias file selects JetBrainsMono Nerd Font for serif and sans-serif and JetBrainsMono Nerd Font Mono for monospace. `fonts.conf` retains synthetic oblique/bold handling, antialiasing, slight hinting and disabled subpixel rendering. These settings are shared across desktops; KDE and Konsole still have their application-specific font settings.

Install the JetBrainsMono Nerd Font families separately. The files contain no username, connector or output IDs. Merge with target font/GTK preferences rather than replacing unrelated settings. GTK appearance can also depend on the target desktop's settings service. Captured versions: GTK 3.24.52, GTK 4.20.4 and Fontconfig 2.18.3.

Snapshot `snapshot-07`, captured 2026-10-03 from local files; no source commit is available. Source paths, source hashes and collection base commit are in [sources.json](../../docs/sources.json). The identical GTK sources are shared with the extra trailing blank line removed; the alias file is unchanged; `fonts.conf` only has trailing whitespace removed.

| Collection file | SHA-256 |
| --- | --- |
| `desktop/common/config/gtk/settings.ini` | `e63b5fe0e20b6a0915e151e2d9efb409b8f9a4d8795b81988266f2cbde4b97cb` |
| `desktop/common/config/fontconfig/conf.d/99-jetbrains-mono.conf` | `3e677f2312d66603952ec91b194f84a119c3745ed16973b959667012df788463` |
| `desktop/common/config/fontconfig/fonts.conf` | `432e2ec71bccf2e27889eb1511763ede5b93a8d7b4df65874e84449163d7ff68` |

GTK settings parsed as INI and Fontconfig XML parsed with xmllint. The existing local aliases resolve to the requested font families with `fc-match`. No GTK or Fontconfig settings were activated from the collection.

`collection-03`, 2026-10-03, documents the distinction between installed fonts, saved files and the affected live application. Align the target GTK settings service's font/monospace choices when authorized, then inspect application rendering; `fc-match` alone cannot prove a live Plasma, Konsole or browser choice. Keep GTK and Fontconfig single shared sources and application-specific overrides with their applications. Dependencies and success criteria are in [validation](../../docs/validation.md); documentation provenance is in [sources.json](../../docs/sources.json).
