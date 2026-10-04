# Preflight and validation

Read the module READMEs, [preferences](preferences.md), [adaptation notes](adapting.md) and [platform boundaries](platforms.md) before deployment. Collection maintenance performs parsing and integrity checks without activating a desktop, display manager, services or hardware. The procedures below are for a separately authorized target deployment.

## Preflight

Record the target inventory outside the clone. Record selected file hashes/backups and every newly created path before edits; exclude credentials, profiles, history, caches and plugin trees from the collection.

| Discover | Read-only checks and interpretation |
| --- | --- |
| Account/home | `id`, `printf '%s\n' "$HOME"`; adapt absolute paths in KConfig, D-Bus Exec and SDDM. These fields cannot expand shell variables. |
| Init/session | `ps -p 1 -o comm=`, `printf '%s\n' "$XDG_SESSION_TYPE" "$XDG_CURRENT_DESKTOP"`; distinguish system services, user services and session D-Bus activation. |
| Kernel/modules | `uname -r`, `ls /usr/lib/modules`; verify modules exist for the running kernel, rather than assuming the installed package is running. |
| Installed/live versions | Use the target package manager (`pacman -Q linux plasma-workspace kwin qt6-base` on the recorded Artix build); compare process mappings with `rg 'libQt6|libKF6|deleted' /proc/<pid>/maps`. Replace `<pid>` with the discovered Plasma/KWin/portal PID. Deleted or older mapped libraries explain stale behavior and private-symbol failures. |
| Authorization | Establish the existing sudo/doas/polkit mechanism before system changes. The recorded deployment used KDE/polkit; unattended sudo was unavailable. Do not request passwords in chat. |
| Browser | Find Root Directory in `about:profiles`; discover the package's policy directory and ownership. Never transplant a generated profile name or copy the profile tree. |
| Fonts | `fc-match 'JetBrainsMono Nerd Font'`, `fc-match 'JetBrainsMono Nerd Font Mono'`; verify the resolved family rather than command success alone. |
| Qt images | Discover Qt's plugin directory and WebP image-format plugin. A matching `qt6-imageformats` package supplied `libqwebp.so` in the observed build; `libwebp` alone did not. Verify decoding/rendering through Qt itself. |
| Displays | `kscreen-doctor -o`; discover connectors, UUIDs, supported modes/refresh/scales before adapting layouts. |
| Input | Inspect `/sys/class/input/event*/device/modalias`, `udevadm info` on discovered devices, and KWin libinput D-Bus objects/capabilities. Event numbers are temporary, and a physical device can expose several interfaces. |
| Battery | Inspect `/sys/class/power_supply/BAT*/charge_control_end_threshold` and permissions. Missing support is a capability limit, not a helper-installation failure. |
| Audio | `cat /proc/asound/cards`, `aplay -l`, `wpctl status`; establish kernel/firmware → ALSA → PipeWire/WirePlumber → physical sound in that order. |

Inspect boot logs through authorized access if firmware is missing or a driver faults. On the documented Intel SOF machine, `sof-firmware` supplied firmware/topology and the package hook rebuilt the installed kernel's initramfs. After an oops and missing old modules, repeated live unbind/rebind attempts stalled. Prefer an explicitly arranged reboot into the matching kernel over speculative legacy-driver overrides. [Hardware evidence](../hardware/audio/README.md) records the user's later confirmation that audio works.

Package names are observations, not a universal install list. Verify availability and versions on the target before installing dependencies. Install image decoders, fonts, firmware and build runtimes before deploying dependent features. Keep downloaded/build/test material outside the clone.

## Evidence and success criteria

Track each feature as **prepared**, **saved**, **activated**, **behavior verified**, or **awaiting session/boot verification**. A registration/readback establishes only its own layer.

| Feature | Required evidence |
| --- | --- |
| Keyboard | Inspect every duplicate HID modifier slot and emitted input events on relevant interfaces; external Command emits Meta and built-in Win stays Meta. Replug/reboot persistence is a separate check. Do not stack remapping layers. |
| Launchers | Confirm the actual `_launch` action and chord, dispatch, and new application/window. An active Firefox component or saved Meta+B is insufficient. Include physical Super+B and reserved/task-manager chords in checks. |
| Tiling/desktops | Exercise focus/swap/layout/floating, fullscreen, desktop 1–5 and shifted-number moves with temporary windows; compare [KDE differences](../keybinds/README.md). |
| Animations/hot corner | Inspect loaded/active effects while switching desktops, then observe physical pointer hover at the top-left launcher. Saved disabled flags alone do not prove live unloading. |
| Fonts/Konsole | Inspect the affected live application's font/profile, not only Fontconfig. Fresh Konsole must use Classic/Mono 9 pt and hide toolbars. GTK settings services can override files. |
| Scrolling | Query and persist `naturalScroll` on all capable interfaces, reconfigure, read back, and test both physical mouse and touchpad. |
| Screenshot | Follow the activated daemon environment and KWin/service/wrapper chain; select a real region and confirm clipboard `image/png` dimensions. This check changes clipboard contents. |
| Wallpapers | Inspect an actual desktop and a fresh lock screen with the system Qt decoder. A screenshot taken while locked proves only that lock-screen process; valid paths/checksums are insufficient. |
| Firefox | After restart, inspect policies, active extensions, UI computed font and rendered page font. A separate temporary instance preserves active tabs but does not prove existing windows reloaded. |
| Neovim | Wait for asynchronous plugin/parser/Mason installation; verify startup, parser, initialized LSP/tools, all captured plugin commits and actual nvimide layout. A lockfile alone is insufficient. |
| Bash | In a fresh interactive terminal, check nonempty `BASH_VERSION` and `BLE_VERSION`. Noninteractive startup must remain quiet. |
| SDDM | Isolated Qt6 theme rendering establishes appearance only. The next real greeter must render and authenticate into Plasma Wayland; X11 greeter selection is separate. |
| Battery | Read back 80, inspect selected boot service, then verify after reboot/device change. Charge already above 80 need not fall immediately. |
| Audio | Real ALSA cards and output/input routes, then audible playback. Test microphone separately; user-confirmed audio does not establish every route or microphone. |

Choose the smallest justified reload when activation is authorized. Do not restart KWin, log out, reboot or restart the display manager merely to validate a reference collection. Distinguish a Plasma-shell refresh from a full new session. List changes needing Firefox restart, next lock, next greeter or boot verification explicitly. Remove probes, temporary windows/applets/profiles and protocol logging; restore the user's working state.

## Observed compatibility

These versions describe the deployment report, not minimum or guaranteed-supported versions.

| Component | Observed build and adaptation point |
| --- | --- |
| Plasma/KWin | 6.7.5; package IDs, scripting/QML, panel containment recreation, pager enum and effect APIs require target checks. Earlier live processes retained 6.7.4. |
| Qt | 6.11.2 installed, 6.11.1 initially live; QML private symbols and image plugins must match the running toolkit. |
| KGlobalAccel | `SetPresent | NoAutoloading = 2 | 4 = 6` in this build; inspect current API and actual `_launch` action. |
| Konsole/Dolphin | 26.08.1 in deployment; earlier collection captures remain separately versioned. Live Konsole can cache its profile list. |
| Firefox | 157.0; internal CSS selectors, preferences, policy schema and package path need review after updates. |
| Neovim | 0.12.5; all 32 lockfile commits matched in deployment. Verify plugin/runtime compatibility and asynchronous tools rather than changing locks speculatively. |
| Shell/helpers | Bash 5.3.20, ble.sh 0.4.0-devel4+d81fd54; screenshot service needs Python dbus-python/PyGObject, keyboard ioctl adapter targets Linux x86_64. |
| Services/audio | dinit 0.22.1, PipeWire 1.6.9, WirePlumber 0.5.18; use the target's existing user/system service boundaries. |

The old 2026-10-01 validation covered integrity, links and available parsers before later refactors; those refactors were skipped at the user's request. The 2026-10-03 collection check is recorded below after validation and does not imply target activation.

## Collection check — 2026-10-03

Changed shell/Python/JavaScript/JSON files passed available parsers; selected INI/KConfig and SVG XML parsed, and four moved QML files passed the standalone syntax verifier. Qt6 qmllint additionally reported unavailable KWin import context and existing unqualified/implicit runtime-property warnings in captured QML; this is not a clean full Qt6 semantic lint or a live greeter/widget test. ShellCheck and dinitcheck were unavailable. No Lua implementation changed.

A mocked duplicate-HID check verified eight modifier entries, idempotent second application/readback and rejection of malformed paths/unrelated device identities; no input device was opened. All 15 KWin script registrations/chords matched the saved assignments in a stubbed API check. Firefox preferences had unique literal values, and neofetch’s built-in logo/palette substitutions passed a local helper check. Markdown links, runtime-ID references, file/symlink manifest hashes and Git whitespace were checked. No desktop/greeter/hardware activation, package installation, live cursor/input/font verification or new plugin bootstrap was performed. Earlier deployment behavior evidence and the user's subsequent audio confirmation are explicitly distinguished above.
