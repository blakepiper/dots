# Keybinding vocabulary

Super is the primary desktop modifier (KDE calls it Meta, OXWM uses Mod4). On the external Gaming Keyboard, the physical Command position should emit Super; device mappings live in [hardware/keyboard](../hardware/keyboard/README.md). Arrow bindings follow stack order: Left/Up go backward, Right/Down go forward, rather than promising spatial focus.

This table records the shared intent and current implementations. A dash means that the collected configuration does not assign that action to this chord. The actual binding files remain authoritative.

| Chord | Preferred action | KDE snapshot | OXWM / Hyprland snapshots |
| --- | --- | --- | --- |
| Super+Enter | Terminal | Konsole | st / Foot |
| Super+Space | App launcher | KRunner | dmenu / Fuzzel |
| Super+D | Alternate launcher | Peek at desktop | App launcher |
| Super+B | Browser | Firefox | Firefox |
| Super+F | File manager | Dolphin | Xfe |
| Super+V | Clipboard history | Plasma clipboard | X11 text history / Cliphist |
| Super+L | Lock session | KDE locker | xss-lock/i3lock / Hyprlock |
| Super+Q | Close window | Close | Close |
| Super+Shift+Q | Exit desktop | — | Exit WM/compositor |
| Super+Shift+Space | Control menu | — | Lock/power/session menu |
| Super+Shift+S | Region screenshot to clipboard | Flameshot through KWin/D-Bus | scrot / grim+slurp; also saves image |
| Print | Full screenshot | — | Full screenshot |
| Alt+Print | Window screenshot | — | Focused-window screenshot |
| Super+P | Toggle floating | Custom tiling script | Toggle floating |
| Super+Shift+F | Fullscreen | Fullscreen | Fullscreen |
| Super+C | Master/stack layout | Custom master/stack | Tiling / master |
| Super+R | Recursive splits | Custom recursive split | Dwindle |
| Super+N | Cycle layouts | Master/recursive | WM layout cycle / master-dwindle toggle |
| Super+- / Super+= | Shrink/grow first split | First split ratio | Master factor / current layout ratio |
| Super+Shift+- / Super+Shift+= | Decrease/increase master count | — | Master count controls |
| Super+arrows | Previous/next window | Custom stack focus | Stack cycle |
| Super+Shift+arrows | Swap/reorder window | Custom stack swap | Stack move / swap |
| Super+Ctrl+arrows | Previous/next monitor | Changes desktop in arrow direction | Monitor focus |
| Super+Ctrl+Shift+arrows | Move window to monitor | Moves window between desktops | Move window to monitor |
| Super+number | Select numbered workspace | 1–5; 6–9 still task-manager entries | 1–9 |
| Super+Shift+number | Send window to workspace | 1–5; stored as shifted symbols `! @ # $ %` | 1–9 |
| Super+Tab | Previous numbered workspace | Previous desktop | Previous tag/workspace |
| Volume/mute/mic keys | Audio controls | Plasma audio | wpctl |
| Media play/next/previous | Media controls | Plasma media | playerctl |
| Brightness keys | Adjust panel brightness | PowerDevil | brightnessctl via helper / directly |

The current KDE snapshot also preserves standard shortcuts such as Alt+Tab, Super+W overview, Super+G grid, and Super+T tile editor. The 2026-10-03 preference keeps these KDE differences: Super+D peeks at the desktop, Ctrl+arrow chords navigate desktops/move windows, and only 1–5 select desktops. 6–9 remain task-manager assignments even though the captured panel has no task manager. Print/Alt+Print remain unassigned. Disabling the top-left hover edge leaves keyboard Overview/Grid available.

Implementations: [KDE assignments](../desktop/kde/config/kglobalshortcutsrc) plus [custom tiling](../desktop/kde/share/kwin/scripts/kde-tiling/contents/code/main.js), [OXWM Lua](../desktop/oxwm/config.lua), and [Hyprland Lua](../desktop/hyprland/config/hypr/hyprland.lua). KDE shortcut values include current/default/description fields; a default chord is not necessarily the active chord.

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

Arrow navigation is spatial here, unlike the stack-order bindings in the other collected tiling configs. Workspace moves transfer a column rather than a single window. Super+C and Super+Shift+Q are not assigned in the Niri snapshot.

`collection-03`, 2026-10-03: final KDE intent and functional shortcut IDs are documented here; executable bindings stay with KDE. Validate device mapping, action presence, registration, dispatch and resulting behavior separately, especially Super+B and Super+Shift+S. `_launch` is a real launcher action, not metadata. See [KDE activation](../desktop/kde/activation.md) and [source records](../docs/sources.json).
