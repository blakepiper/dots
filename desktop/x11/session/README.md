# X11 locker layout

Use the same `xinitrc` and lock helpers on either layout. Merge one example into `~/.config/workstation/x11-session.conf`:

- `portable/x11-session.conf` selects the target's `i3lock` from PATH.
- `privileged/x11-session.conf` preserves the captured `/run/privileged/bin/i3lock` path.

This is trusted shell configuration. Both session startup and the lock helper read it, honoring `XDG_CONFIG_HOME`, and export `I3LOCK_BIN` for child processes. Without a file, `i3lock` is used. Either selection requires working target PAM authentication. xss-lock and `loginctl lock-session` still depend on a compatible login/session manager; selecting a locker path does not replace that integration.

Power commands are a separate [shared profile](../../common/README.md). No duplicate X11 desktop config is needed for these choices. Factored on 2026-10-01 with capture/edit records retained; validation was skipped at the user's request.
