# greetd with tuigreet

Optional minimal console greeter for the [XFCE startx session](../xfce/README.md). `etc/greetd/config.toml` is an example for `/etc/greetd/config.toml`, independent of the user application settings. Install greetd and tuigreet using the target's packages; their service/PAM integration and a local seat/session manager must be provided by the distribution.

The example shows time, authenticates a user, then runs `startx`, which reads that user's adapted `~/.xinitrc`. It does not autologin. Logging out returns to the greeter. It deliberately does not remember commands or sessions that could override the selected startup command. See [tuigreet's command and session documentation](https://github.com/tuigreet/tuigreet#session-persistence).

`greeter` is the unprivileged service account, not your login username; adapt it to the account created by your distribution. `vt = 1` selects tty1. Reserve that console for greetd and use a different console for manual login/startx. Choose this greeter instead of another display manager or getty owning tty1. Keep a working console login available when adapting the example.

The service must be able to find `tuigreet`, and the authenticated user's session must find `startx`, `startxfce4` and the shortcut commands. On systems with immutable/package-store paths, express these paths through the platform's service/package configuration. No system service units, PAM files or NixOS host module are imported here, and no service is enabled by this collection.

`snapshot-23`, 2026-11-04: newly authored integration example requested alongside XFCE; no existing greeter config was found in the reviewed source snapshot. [Source records](../../docs/sources.json) record its hash and adaptations. TOML was parsed; greetd authentication, seat ownership, Xorg startup and greeter return were not runtime-tested. No live configuration was changed.
