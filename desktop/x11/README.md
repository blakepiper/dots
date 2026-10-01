# Shared X11 session material

This material supports OXWM but is kept separate from its WM settings. `xinitrc` initializes the session, input/display helpers, runtime state and logging; helper processes are cleaned up when OXWM exits. It uses the inherited system PATH plus user-local commands and uses a configurable authenticated locker; choose the [locker layout](session/README.md) appropriate to the target.

`config/picom/picom.conf` keeps windows opaque without fading/shadows. `config/gammastep/config.ini` is an optional night-color reference; the session does not launch it. `bin/` contains the control menu, clipboard history, region/full/window screenshot command, and locking/diagnostic helpers. The screenshot command uses the primary X11 scrot behavior, including the composited-selection patch in `reference/scrot/`.

The X session expects the command `workstation-clipwatch`; `src/clipwatch.c` is its XFixes event watcher source. It can be compiled for a target with X11/Xfixes headers using `cc -O2 src/clipwatch.c -o workstation-clipwatch -lX11 -lXfixes`. Its clipboard helper requires the chosen X selection utilities and dmenu; inspect script commands for the target package equivalents.

The control menu also requires `desktop-power` and a chosen [power profile](../common/README.md).

Useful runtime dependencies include Xorg/startx, xrandr, xinput, setxkbmap, xset, xsetroot, coreutils/timeout, udevadm, feh, Picom, dmenu, xdotool, xclip, scrot, xss-lock, loginctl and i3lock with working target authentication. `../../hardware/x11/` (see [hardware](../../hardware/README.md)) supplies monitor/input helpers; [OXWM](../oxwm/README.md) supplies the WM/status helpers. Horizon wallpaper is in [walls](../../walls/README.md).

Lock and suspend behavior must be verified on the destination system before relying on it. Collection checks only parse the captured code; they do not test target PAM, sleep inhibitors or a running X session.
