# Hyprland session alternatives

The [shared config and helpers](../README.md) are used by both alternatives. Choose the backend with `HYPRLAND_SESSION_BACKEND=systemd` or `portable` in the session environment. The default is `portable`. Copy the chosen backend directory to `~/.config/hypr/session/<backend>/`; the scripts honor `XDG_CONFIG_HOME`.

Launch the shared `hyprland-session` command from a login with no running desktop. It starts Hyprland, forwards termination signals, and invokes backend cleanup after the compositor exits. The shared Lua startup hook calls `workstation-hyprland-session`, which selects the same backend.

- **systemd:** put `systemd/user/*` in `~/.config/systemd/user/` and reload the user manager when adopting them. The target starts the four services without enabling them individually. Units restart failed helpers and scope them to the target. The backend imports D-Bus/user-manager environment and restarts portal services around the session.
- **portable:** `portable/backend.sh` starts Waybar, swaybg, clipboard capture and Hypridle directly. It tracks child processes, observes the compositor's IPC lifetime and terminates children when the session ends. flock prevents duplicate supervisors. Failed helpers are not restarted automatically. The login must provide a private `XDG_RUNTIME_DIR` and user D-Bus. D-Bus activation/platform services must provide portals; this backend does not stop or restart an externally managed portal daemon.

Both retain the same Hypridle lock-before-sleep settings. Those require a compatible logind/elogind and PAM setup on the target. No init-independent suspend implementation is implied. Choose the shared [power profile](../../common/README.md) separately from session supervision.

These are alternatives, not services to run together. Added 2026-10-01; source records describe the captured systemd units and subsequent portable implementation. No backend was activated or validated during collection maintenance.
