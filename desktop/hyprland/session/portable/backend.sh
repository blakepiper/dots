#!/usr/bin/env bash
# The startup hook owns this supervisor; the compositor's IPC lifetime ends it.
set -euo pipefail
runtime=${XDG_RUNTIME_DIR:?A private login runtime directory is required}
lock="$runtime/workstation-hyprland-session.lock"
case ${1:-} in
    prepare)
        exec 9>"$lock"
        flock -n 9 || { echo 'Hyprland helpers are already active.' >&2; exit 1; }
        ;;
    stop)
        # The IPC connection disappears when Hyprland exits; wait for cleanup.
        exec 9>"$lock"
        flock -w 10 9 || { echo 'Hyprland helper cleanup is still pending.' >&2; exit 1; }
        ;;
    start)
        exec 9>"$lock"
        flock -n 9 || exit 0
        dbus-update-activation-environment DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE \
            XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE PATH TERMINAL MOZ_ENABLE_WAYLAND \
            XDG_CONFIG_HOME FONTCONFIG_FILE HYPRLAND_APP_FONTCONFIG_FILE HYPRLAND_SESSION_BACKEND
        pids=()
        cleanup() {
            trap - EXIT HUP INT TERM
            for pid in "${pids[@]}"; do kill -TERM "$pid" 2>/dev/null || true; done
            for pid in "${pids[@]}"; do wait "$pid" 2>/dev/null || true; done
        }
        trap cleanup EXIT
        trap 'exit 0' HUP INT TERM
        # Children must not inherit the supervisor lock.
        workstation-hyprland-bar 9>&- & pids+=("$!")
        workstation-hyprland-wallpaper 9>&- & pids+=("$!")
        workstation-hyprland-idle 9>&- & pids+=("$!")
        if command -v hyprsunset >/dev/null; then
            hyprsunset 9>&- & pids+=("$!")
            if command -v desktop-settings-apply >/dev/null; then
                desktop-settings-apply apply-hyprland-nightlight 9>&- & pids+=("$!")
            fi
        fi
        if command -v desktop-settings-apply >/dev/null; then
            desktop-settings-apply watch-session 9>&- & pids+=("$!")
        fi
        while hyprctl -j monitors >/dev/null 2>&1; do sleep 1; done
        ;;
    *) exit 2 ;;
esac
