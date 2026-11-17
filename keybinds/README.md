# Keybinding vocabulary

Super is the primary desktop modifier (KDE calls it Meta, OXWM uses Mod4). On the external Gaming Keyboard, the physical Command position should emit Super. See the [device mappings](../hardware/keyboard/README.md). Stack-order bindings use Left/Up for backward and Right/Down for forward. Hyprland and Niri use directional window focus.

This table records the shared intent and current implementations. A dash means that the collected configuration does not assign that action to this chord. The actual binding files remain authoritative.

| Chord | Preferred action | KDE snapshot | OXWM snapshot | Hyprland snapshot |
| --- | --- | --- | --- | --- |
| Super alone | No action | Application menu disabled | — | — |
| Super+Enter | Terminal | Konsole | st | Ghostty |
| Super+Space | App launcher | KRunner | dmenu | Wofi |
| Super+D | Alternate launcher | Peek at desktop | dmenu | Wofi |
| Super+B | Browser | Firefox | Firefox | Firefox |
| Super+Shift+B | Private browser window | Firefox private window | — | Firefox private window |
| Super+F | File manager | Dolphin | Xfe | Thunar |
| Super+S | Desktop settings | — | — | Desktop Settings |
| Super+V | Clipboard history | Plasma clipboard | X11 text history | — |
| Super+L | Lock session | KDE locker | xss-lock/i3lock | Hyprlock through logind/Hypridle |
| Super+Q | Close window | Close | Close | Close |
| Super+Shift+Q | Exit desktop | — | Exit WM | Exit compositor |
| Super+Shift+Space | Control menu | — | Lock/power/session menu | Wofi lock/power/session menu |
| Super+Shift+S | Region screenshot to clipboard | Flameshot through KWin/D-Bus | scrot, also saves image | grim + slurp, also saves image |
| Print | Full screenshot | — | Full screenshot | Full screenshot |
| Alt+Print | Window screenshot | — | Focused-window screenshot | — |
| Super+P | Toggle floating | Custom tiling script | Toggle floating | Toggle floating |
| Super+Shift+F | Fullscreen | Fullscreen | Fullscreen | Fullscreen |
| Super+C | Master/stack layout | Custom master/stack | Tiling | — |
| Super+R | Recursive splits | Custom recursive split | Dwindle | — |
| Super+N | Cycle layouts | Master/recursive | Layout cycle | — |
| Super+- / Super+= | Shrink/grow first split | First split ratio | Master factor | — |
| Super+Shift+- / Super+Shift+= | Decrease/increase master count | — | Master count controls | — |
| Super+arrows | Previous/next window | Custom stack focus | Stack cycle | Directional focus |
| Super+Shift+arrows | Swap/reorder window | Custom stack swap | Stack move | Directional swap |
| Super+Ctrl+arrows | Previous/next monitor | Changes desktop in arrow direction | Monitor focus | Previous/next monitor with Left/Right |
| Super+Ctrl+Shift+arrows | Move window to monitor | Moves window between desktops | Move window to monitor | Move window to previous/next monitor with Left/Right |
| Super+number | Select numbered workspace | 1–5 (6–9 still task-manager entries) | 1–9 | 1–9 |
| Super+Shift+number | Send window to workspace | 1–5 (shifted symbols `! @ # $ %`) | 1–9 | 1–9 |
| Super+Tab | Previous numbered workspace | Previous desktop | Previous tag | Previous workspace (`e-1`) |
| Volume/mute/mic keys | Audio controls | Plasma audio | wpctl | wpctl |
| Media play/next/previous | Media controls | Plasma media | playerctl | playerctl |
| Brightness keys | Adjust panel brightness | PowerDevil | brightnessctl via helper | brightnessctl on systems with a backlight |

The current KDE snapshot also preserves standard shortcuts such as Alt+Tab, Super+W overview, Super+G grid, and Super+T tile editor. The 2026-10-03 preference keeps these KDE differences: Super+D peeks at the desktop, Ctrl+arrow chords navigate desktops/move windows, and only 1–5 select desktops. 6–9 remain task-manager assignments even though the captured panel has no task manager. Print/Alt+Print remain unassigned. Disabling the top-left hover edge leaves keyboard Overview/Grid available.

The 2026-10-04 preference disables the KDE application menu on Super alone. Alt+F1 still opens that menu; Super+Space still launches KRunner.

`snapshot-16`, 2026-10-04, adds Super+Shift+B for Firefox's built-in `new-private-window` desktop action on KDE; Super+B retains the normal `_launch` action. The chord was unassigned before registration. KGlobalAccel readback and saved settings confirmed the binding, and invoking the action opened a visibly private Firefox window. Physical keyboard activation remains a separate check; this collection update did not activate desktop settings.

Implementations: [KDE assignments](../desktop/kde/config/kglobalshortcutsrc) plus [custom tiling](../desktop/kde/share/kwin/scripts/kde-tiling/contents/code/main.js), [OXWM Lua](../desktop/oxwm/config.lua), and [Hyprland Lua](../desktop/hyprland/config/hypr/hyprland.lua). KDE shortcut values include current/default/description fields; a default chord is not necessarily the active chord.

The 2026-11-17 Hyprland capture (`snapshot-29`) starts in dwindle. Super+G launches Steam when it is on PATH. Super with the left or right mouse button drags or resizes a window, respectively. The [Hyprland module](../desktop/hyprland/README.md) documents its session commands and optional clipboard helper.

Application-specific bindings belong with the app. Neovim uses LazyVim defaults plus the collected plugin options; `nvimide` changes layout rather than defining a new keybinding layer. The tmux fragment enables mouse support and otherwise retains tmux defaults.

## Niri differences

[Niri's desktop snapshot](../desktop/niri/config/niri/config.kdl) shares the application launcher, browser, file manager, clipboard, lock, close, floating, screenshot and control-menu vocabulary above. It uses Kitty, Fuzzel, Nautilus, Cliphist and Hyprlock. Region capture opens Niri's selection UI; Enter saves/copies and Escape cancels.

Niri's columns make the following differences intentional; use this table when adapting the shared preferences.

| Chord | Niri action |
| --- | --- |
| Super+Shift+Enter | Launch prettymux |
| Super+Shift+F | Maximize column (rather than fullscreen) |
| Super+O | Toggle overview |
| Super+Tab | Focus previous workspace |
| Super+N | Cycle night mode (rather than cycle layouts) |
| Super+Shift+E | Quit compositor |
| Super+Shift+P | Power off monitors |
| Super+Left / Right | Focus column left / right |
| Super+Up / Down | Focus window up / down |
| Super+Shift+Left / Right | Move column left / right |
| Super+Shift+Up / Down | Move window up / down |
| Super+Ctrl+arrows | Focus monitor in that direction |
| Super+Ctrl+Shift+arrows | Move column to monitor in that direction |
| Super+number / Super+Shift+number | Focus named workspace / move column there, 1–9 |
| Super+- / Super+= | Change column width by −10% / +10% |
| Super+Shift+- / Super+Shift+= | Change window height by −10% / +10% |
| Super+R | Reset window height (rather than select dwindle) |
| Super+Shift+R | Cycle preset column widths |
| Super+Shift+C | Center column |
| Super+, / Super+. | Consume or expel a window left / right |

Niri uses spatial arrow navigation and transfers a full column on workspace moves. Super+C and Super+Shift+Q are unassigned in its snapshot.

`collection-03`, 2026-10-03: final KDE intent and functional shortcut IDs are documented here; executable bindings stay with KDE. Validate device mapping, action presence, registration, dispatch and resulting behavior separately, especially Super+B and Super+Shift+S. `_launch` is a real launcher action, not metadata. See [KDE activation](../desktop/kde/activation.md) and [source records](../docs/sources.json).

## XFCE differences

[XFCE shortcuts](../desktop/xfce/config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml), `snapshot-23`, 2026-11-04, keep Super as the desktop modifier and use native XFCE applications with Xfwm4. The custom sets replace distribution shortcuts. These differences apply to the shared table above:

| Chord | XFCE action |
| --- | --- |
| Super+Enter | xfce4-terminal |
| Super+Space / Super+D | Collapsed Appfinder launcher |
| Super+B / Super+Shift+B | Firefox / private Firefox window |
| Super+F / Super+S | Thunar / XFCE Settings |
| Super+V / Super+L | Clipman popup / xflock4 |
| Super+Q / Super+Shift+F | Close / fullscreen |
| Super+Shift+Q | Request XFCE logout |
| Super+Shift+Space | XFCE session/power dialog |
| Super+Shift+S / Print / Alt+Print | Region / full / active-window screenshot to clipboard; no automatic file save |
| Super+Left or Up / Right or Down | Cycle windows backward / forward (switcher order, not spatial focus) |
| Super+number / Super+Shift+number | Select workspace / send window there, 1–5; shifted symbols assume a US layout |
| Super+Tab | Previous numbered workspace |
| Super+Ctrl+Shift+arrows | Move window to the monitor in that direction (spatial, unlike OXWM monitor order) |
| Audio / media / brightness keys | wpctl / playerctl / brightnessctl; dependencies and permissions required |

Alt+Tab, Alt+Shift+Tab and Alt+F4 retain window cycling and close. Super alone is unassigned. Floating/tiling-layout controls (Super+P/C/R/N and split/master-count chords), Super+Shift+arrows for stack swaps and Super+Ctrl+arrows for monitor focus remain unassigned because stock Xfwm4 does not supply the collected tiling behavior. Locking needs a configured locker; clipboard commands need Clipman running. The [XFCE README](../desktop/xfce/README.md) records startup, package assumptions and untested target behavior.
