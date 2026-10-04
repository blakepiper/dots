# SDDM

`etc/sddm.conf.d/01-greeter.conf` clears the virtual keyboard input method and selects X11 for the greeter; `90-sddm-minimal.conf` selects the custom theme. `themes/sddm-minimal/` preserves the selected theme layout and its own wallpaper from the captured `/usr/share/sddm/themes/` tree. `collection-03`, 2026-10-03, renamed files and runtime theme ID by function; license/author fields are retained. Previous and current hashes are in [sources.json](../../docs/sources.json).

The theme presents a password field over the background. `theme.conf` defaults to user `przvl`; `Main.qml` also has that fallback. Adapt both for another account. The wallpaper is independent of [desktop wallpapers](../../walls/README.md). The X11 greeter and Plasma Wayland desktop are separate choices.

Inspect SDDM's effective configuration, including `/etc/sddm.conf` and distribution defaults: a higher-precedence setting can override a theme drop-in. Validate the theme in an isolated Qt6 greeter before selecting it for the next login. The reported deployment rendered it successfully in isolation; real PAM authentication was still pending, and the user's audio confirmation does not change that status. See [validation](../../docs/validation.md) and [rollback](../../docs/rollback.md).

No PAM configs or authentication state were copied, and no active display manager was restarted by collection maintenance.
