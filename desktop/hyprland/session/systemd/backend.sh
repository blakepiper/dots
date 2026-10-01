#!/usr/bin/env bash
set -euo pipefail
target=workstation-hyprland-session.target
portals=(xdg-desktop-portal.service xdg-desktop-portal-hyprland.service xdg-desktop-portal-gtk.service)
case ${1:-} in
    prepare)
        if systemctl --user is-active --quiet "$target"; then
            echo 'Hyprland helpers are already active.' >&2; exit 1
        fi
        systemctl --user stop "${portals[@]}" || true
        ;;
    start)
        dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE \
            XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE PATH TERMINAL MOZ_ENABLE_WAYLAND
        systemctl --user start "$target"
        ;;
    stop)
        systemctl --user stop "$target" "${portals[@]}" || true
        systemctl --user unset-environment DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE \
            XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE TERMINAL MOZ_ENABLE_WAYLAND || true
        ;;
    *) exit 2 ;;
esac
