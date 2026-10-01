# Niri session and Awake alternatives

Use the shared `niri-session` wrapper with `NIRI_SESSION_BACKEND=systemd` or `portable` in the session environment. The default is `portable`. Both use the same KDL startup, application configs, control menu and `keep-awake` UI. The startup environment helper imports D-Bus variables and adds user-manager import only for systemd. The wrapper stops the selected Awake backend when Niri exits.

Copy the chosen backend directory to `~/.config/niri/session/<backend>/` (honoring `XDG_CONFIG_HOME`), preserving executable permissions on `awake` and `environment`.

- **systemd:** copy `systemd/user/keep-awake.service` into `~/.config/systemd/user/` and reload the user manager when adopting it. The `awake` adapter starts/stops that unit and reports its state. It uses systemd-inhibit and has the captured restart behavior. The unit does not need enabling; the toggle starts it explicitly.
- **portable:** `portable/awake` is a Python standard-library supervisor and local control socket. It starts elogind-inhibit directly, waits for inhibitor acquisition before reporting active, and terminates inhibition on toggle-off/session exit. It requires Python 3, a private login runtime directory and elogind's inhibition interface. `NIRI_INHIBIT_COMMAND` may name another compatible executable with the same arguments. Inhibitor failure turns the state off; it is not restarted automatically. Runtime socket, lock and diagnostic log stay outside the repository.

Awake has the same intended scope in both variants: block idle, sleep and lid-switch actions while guarding the configured automatic actions. Neither variant can provide sleep inhibition without a cooperating login/power manager. Manual power requests, locker authentication and before-sleep hooks still require target integration.

Choose [desktop/common power commands](../../common/README.md) separately. Niri's Mako, Waybar, swayidle, clipboard and other startup programs remain shared compositor-launched processes. These alternatives do not add a second copy of the desktop or promise service-manager supervision of every helper.

Added 2026-10-01; records preserve the captured unit and document derived adapters. No session or account helpers were activated; validation was skipped at the user's request.

Updated 2026-10-01: portable Awake toggle-off waits for the supervisor lock to be released after inhibitor cleanup, so a following toggle-on does not race shutdown. Validation of this fix was skipped at the user's request.
