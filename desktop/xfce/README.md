# XFCE

Minimal X11 session and preferred shortcuts for XFCE 4.18/4.20 with Xfwm4. Panel, theme, wallpaper, compositor and hardware settings retain the distribution defaults. This module is independent of the other desktops and their helpers.

## Files and dependencies

- `config/xfce4/xfconf/xfce-perchannel-xml/` maps to the same path under `~/.config/` (or `$XDG_CONFIG_HOME`). The shortcuts file defines command and window-manager bindings; `xfwm4.xml` sets five workspaces.
- `xinitrc` is an example `~/.xinitrc`. It selects XFCE, adds `~/.local/bin` to PATH and delegates startup to `startxfce4`.

Install Xorg, xinit/startx, XFCE session/settings, Xfwm4, xfce4-panel, xfdesktop, Thunar, xfce4-terminal and xfce4-appfinder. Commands use PATH so substitute your preferred terminal, browser or file manager in the XML. Firefox is the browser example; no username, output connector or device ID is embedded. Shared terminal/shell/application preferences can be selected separately.

Shortcuts additionally use xfce4-screenshooter, xfce4-clipman-plugin, a working locker behind `xflock4`, WirePlumber's `wpctl`, playerctl and brightnessctl. Run Clipman once per session, using its packaged autostart entry, the panel plugin, or an entry in Session and Startup; avoid duplicate instances. Clipboard capture needs a running clipboard manager. Brightness commands assume an internal backlight and target permissions; remove them for a desktop or adapt them to monitor controls. Avoid another volume/brightness/media handler registering the same keys.

Adapt existing settings while logged out of XFCE, with the user's xfconfd stopped, so its cached state cannot overwrite file edits. Back up and merge any existing channels first: these are curated custom shortcut sets with `override=true`, not additive snippets preserving distribution shortcuts. The Shift+number entries use US-layout shifted keysyms (`exclam` through `percent`); record the symbols emitted by your layout and adjust them if needed. Super alone has no binding here; check for a distribution panel/menu binding if it still opens a menu.

## Start manually from a TTY

After adapting `xinitrc` as `~/.xinitrc`, log into a local console as your normal user and run:

```sh
startx
```

There is no automatic X launch in `.profile` or `.bash_profile`. Logging out ends X and returns to the console shell. This alternative does not require a display manager. The target must provide a working local seat, Xorg permissions and a session D-Bus; `startxfce4` uses XFCE's packaged session initialization. Preserve any distribution-required xinit hooks when merging an existing `.xinitrc`. Do not combine this with the OXWM-specific `desktop/x11/xinitrc` or run its Picom/lock/session supervisor alongside XFCE.

The optional [greetd/tuigreet example](../greetd/README.md) runs the same `startx` command after authentication. It is a separate login choice; manually starting from a normal TTY remains available on another console.

## Shortcut behavior

See the [shared vocabulary and XFCE differences](../../keybinds/README.md#xfce-differences). App commands use XFCE tools; Super+S opens Settings. Super+Shift+Space opens the session/power dialog. Super+Shift+Q requests logout through XFCE's normal flow. Screenshots copy to the clipboard without automatically saving an image.

Xfwm4 supplies stacking windows, fullscreen, window cycling, five workspaces and directional moves to monitors. Master/stack, dwindle, layout ratios, floating toggles, stack reordering and monitor-focus chords have no bindings here. No replacement WM, tiling plugin or geometry helper is included. Super+Tab selects the previous numbered workspace, not the last visited workspace.

`xflock4` delegates to the installed locker; install and configure one (for example xfce4-screensaver with the target's PAM integration). Verify actual authentication and suspend locking on the target before relying on it. A keybinding alone does not configure automatic locking.

## Capture and validation

`snapshot-23`, 2026-11-04, derives shortcut intent and explicit TTY startup from reviewed X11 configuration at commit `caa52d034a0ac04360c9776fe9d5c046f69068cb`. These are newly written XFCE examples, not an existing XFCE capture. Five workspaces follow the user's review preference. The extra private-browser chord follows this collection's preferred vocabulary. Source input hashes, output hashes and adaptations are recorded in [sources.json](../../docs/sources.json); no imported code or license notices were removed.

XML structure, unique bindings across both providers, workspace coverage, shell syntax/ShellCheck, greeter TOML and manifest hashes were checked. XFCE, Xorg startup, physical keys, clipboard, logout, locking and greetd were not run; the required desktop runtimes are unavailable in the maintenance environment. No live settings were changed.

Command behavior was checked against the application documentation: [Screenshooter](https://docs.xfce.org/apps/xfce4-screenshooter/usage), [Clipman](https://docs.xfce.org/panel-plugins/xfce4-clipman-plugin/start), and [Xfwm4 action identifiers](https://github.com/xfce-mirror/libxfce4ui/blob/master/libxfce4kbd-private/xfce-shortcuts-xfwm4.c).
