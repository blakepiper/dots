# Shared desktop integration

Desktop application settings stay with their desktop. These small helpers cover shared platform boundaries without requiring copies of those settings. Added 2026-10-01; source records are in [sources.json](../../docs/sources.json).

Put selected `bin/` helpers on PATH. X11, Hyprland and Niri control menus use `desktop-power`. Choose **one** profile from `power/systemd/`, `power/elogind/`, or `power/portable/`, and merge it into `~/.config/workstation/power.conf`. `DESKTOP_POWER_CONFIG` can select another absolute path. Profiles are trusted Bash code containing command arrays; inspect them before use.

The systemd profile invokes systemctl. The elogind profile uses elogind's loginctl power verbs; systemd's loginctl does not provide those same power commands. The portable profile illustrates direct platform tools (`zzz` and `shutdown`) and requires adapting command availability, flags and authorization. Missing configuration is an error rather than an automatic choice of a power manager. Session managers, lockers and platform sleep hooks remain responsible for lock-before-suspend integration.

Niri also uses `desktop-polkit-agent`. It recognizes common KDE/GNOME authentication agent installation paths. Set `POLKIT_AGENT` in the session environment to an absolute executable path on another layout. This helper starts an agent, not a polkit system service.

D-Bus, logind/elogind, PAM, udev and application daemons are distinct dependencies. A portable session supervisor removes dependence on systemd **service management**; it does not provide authentication, portals, device discovery or sleep inhibition itself.
