# Picom transparency

Standalone X11 compositor settings shared by the desktop examples. `config/picom/picom.conf` maps to `~/.config/picom/picom.conf` (or `$XDG_CONFIG_HOME/picom/picom.conf`). This single template replaces the older opaque-only config under `desktop/x11/`; that session still reads the same installed user path.

The rules preserve the preferred behavior:

| Window | Opacity / behavior |
| --- | --- |
| Unfocused | 80% opaque |
| Focused | 85% opaque |
| Firefox active-tab video playing | 100% opaque |
| Steam game | 100% opaque; allow compositor bypass |
| Optional opaque mode | Every window 100% opaque, overriding client opacity hints |

XRender, vsync and damage tracking are enabled. Shadows, fading, background blur and rounded corners are disabled. Later matching rules override earlier values. The Steam exception uses `STEAM_GAME` and `steam_app_` window properties, not an ordinary Steam client title. Fullscreen bypass depends on Picom and the application.

## Firefox video integration

The [Firefox extension](../../browser/firefox/video-opacity/README.md) prefixes the window title with `[firefox-video] ` while the active tab has a playing video. Picom matches that marker plus `class_g = 'firefox'`. Pausing, ending playback or changing tabs restores ordinary transparency when the marker is cleared. Video in embedded frames is included; x.com and its subdomains are excluded by the extension. The rule affects the whole Firefox window, not just the video rectangle.

The extension must be loaded through the documented browser integration; Picom cannot detect playback by itself. Adapt the class match for a differently branded Firefox package. The marker and extension identifiers are consistent with the collected extension, rather than the source-specific names.

## Transparent or opaque mode

Install Python 3 and map `bin/picom-config` to a command on PATH if using the renderer. It reads the adjacent checkout template when run from this module, otherwise the installed user template; `--config` selects an explicit template. It emits configuration on stdout, without writing preferences or starting/restarting a compositor.

For example, choose one mode and generate a separate runtime file (keep the original template intact):

```sh
# Default: the preferred transparency and exceptions.
picom-config > "$XDG_RUNTIME_DIR/picom.conf"
# Or: all windows opaque, including windows with application opacity hints.
picom-config --opaque > "$XDG_RUNTIME_DIR/picom.conf"
```

Then start your chosen session's compositor with `picom --config "$XDG_RUNTIME_DIR/picom.conf"`. These examples require a writable, user-owned `XDG_RUNTIME_DIR`. Prepare the file before starting Picom and regenerate it only while that instance is stopped, or use an atomic temporary-file replacement in a session/service integration. Passing the template directly to Picom also works for transparent mode because the unused override slot is a comment.

The renderer has no settings menu, saved-preference store or service controller. Choose a mode in the target's existing session configuration. Any runtime updates, persistence, restarts and rollback belong to that session integration.

## Session and locker integration

Use Picom 13 or another build supporting ordered `rules`, `opacity-override` and `unredir`; the previous legacy `opacity-rule` configuration is not equivalent. Dependencies are Picom, a working X11 session, and optionally the Firefox extension/Python renderer. No usernames, connectors or hardware facts are embedded.

Run one compositor. The [X11 session](../x11/README.md) already starts Picom from the installed template. XFCE starts with Xfwm4's compositor: choosing Picom requires disabling Xfwm4 compositing and arranging one Picom process per session. KDE uses KWin compositing and Wayland desktops manage their own effects; this module is not loaded into those compositors. None of those session choices are activated here.

The reviewed source stops Picom before xsecurelock and restores it after unlock only if Picom was previously running and the owning session remains active. Its wrapper preserves the locker exit status and refuses to lock if stopping the compositor fails. This service-specific behavior is not added to the collection's different locker stack. When adopting transparency, verify your locker stays fully opaque and authenticates correctly; adapt any compositor stop/restore wrapper to the actual session owner, including suspend locking. A final opaque rule alone does not reproduce the source locker lifecycle.

## Source and validation

`snapshot-26`, 2026-11-04, reviewed at commit `caa52d034a0ac04360c9776fe9d5c046f69068cb`. The source Picom template is captured with functional marker/comment names. The small renderer extracts its final-rule behavior without source-specific settings/services. [Source records](../../docs/sources.json) retain input hashes, output hashes, previous opaque-config capture and edits. No license/copyright notices were present in the selected template or rendering functions; no existing notices were removed.

Python syntax, transparent/opaque rendering, failure on a malformed template, normalized source parity, marker consistency, JSON/hashes and Git whitespace were checked. Picom 13 accepted the template and both rendered modes using `--diagnostics` on an isolated Xvfb display. Video playback, Steam bypass and locker behavior were not runtime-tested; no live compositor, locker, browser or desktop setting was activated.
