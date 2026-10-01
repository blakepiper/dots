# SDDM

`etc/sddm.conf.d/` contains both current files: Gentoo's base file clears the virtual keyboard input method and selects X11 for the greeter; `90-gentoo-minimal.conf` selects the custom theme. `themes/gentoo-minimal/` is the complete active theme from `/usr/share/sddm/themes/`, including its wallpaper.

The theme presents a password field over the background. `theme.conf` defaults to user `przvl`; `Main.qml` also has that fallback. Adapt both for another account. The wallpaper is preserved as the theme's own asset, independent of `../../walls/`. Qt/SDDM compatibility and live greeter behavior need validation on the target. No PAM configs or authentication state were copied.
