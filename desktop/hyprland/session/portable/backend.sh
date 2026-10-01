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
            XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE PATH TERMINAL MOZ_ENABLE_WAYLAND
        pids=()
        cleanup() {
            trap - EXIT HUP INT TERM
            for pid in "${pids[@]}"; do kill -TERM "$pid" 2>/dev/null || true; done
            for pid in "${pids[@]}"; do wait "$pid" 2>/dev/null || true; done
        }
        trap cleanup EXIT
        trap 'exit 0' HUP INT TERM
        # Children must not inherit the supervisor lock.
        waybar 9>&- & pids+=("$!")
        workstation-hyprland-wallpaper 9>&- & pids+=("$!")
        (umask 077; exec wl-paste --type text --watch cliphist --max-items 100 store) 9>&- & pids+=("$!")
        hypridle 9>&- & pids+=("$!")
        while hyprctl -j monitors >/dev/null 2>&1; do sleep 1; done
        ;;
    *) exit 2 ;;
esac
