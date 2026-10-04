# Preferred behavior

These choices were clarified during the 2026-10-03 KDE deployment. They describe intended behavior separately from older captures and target-specific IDs. The deployment findings are recorded as `snapshot-08` in [sources.json](sources.json); the collection adaptation uses `collection-03`. [Keybindings](../keybinds/README.md) remain the authoritative shortcut intent and difference matrix.

| Area | Preference |
| --- | --- |
| Desktop | Plasma Wayland, retaining the target's existing init/session setup; dinit on the documented Artix machine. |
| Appearance | Dark colors, compact 20px top panel, transparent panel theme, tiling/focus border and CPU/RAM readouts. Blue Arch launcher logo (`#1793d1`), regardless of the actual OS label. |
| Panel | Launcher with 685px popup, numeric pager 1–5, margins separator, expanding spacer, RAM, CPU, battery, system tray and clock. Roles/order are portable; containment/activity/output IDs are not. |
| Desktops | Five desktops named 1–5. Show their indexes, without window icons/outlines or truncated names. No slide, scale, zoom or similar switching transition. |
| Overview | No top-left hover activation. Keep keyboard Overview, Grid and tile editor. |
| Input | Natural scrolling on mouse and touchpad, including every supported interface of composite devices. External Command position emits Super; built-in Win remains Super. Device mapping stays scoped to the keyboard. |
| Wallpaper | `cityview.webp` for desktop and lock screen. SDDM keeps its independent theme background. |
| Fonts | Install JetBrainsMono Nerd Font systemwide, including its Mono family. General text uses the regular family; fixed-width text uses Mono. |
| Terminal | Bash with ble.sh; Konsole Classic, Mono 9 pt, captured colors, hidden menu and New Tab / Split View / Copy / Paste / Find toolbars. |
| Browser | Captured Firefox UI/privacy/policies/extensions, plus the later explicit JetBrains UI and document-font preference. `browser.display.use_document_fonts=0` overrides site fonts and can change layout. |
| Screenshot | Super+Shift+S selects a region and copies it; standard plus crosshair for Flameshot only, with the global Breeze cursor retained. |
| System information | Built-in Arch Linux ASCII logo and cyan/blue headings and palette replacements in neofetch; OS field continues to report the actual distribution. |
| Charging | 80% maximum where supported, now and through boot/device changes. A clamp prevents further charging; it does not actively discharge a battery above 80%. |

Use the [preflight and validation guide](validation.md), [KDE activation notes](../desktop/kde/activation.md), and [rollback guide](rollback.md) when adopting these choices. A saved setting is not behavioral verification. Older modules may retain different fonts, desktop counts or mappings; those snapshots are alternatives, not promises of parity.
