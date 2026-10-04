# Hardware-specific material

| Area | Material | Scope |
| --- | --- | --- |
| [External keyboard](keyboard/README.md) | hwdb, XKB and keyd alternatives | Gaming Keyboard USB `1fc9:e8c7`; physical Command position becomes Super |
| [LG monitor](monitor/README.md) | KWin output snapshot and X11 display policy | Scaling, mirroring and refresh-rate choices |
| [Dell dock](dock/README.md) | Dock-aware helpers and policies | Dynamic DP/MST connectors and reconnection behavior |
| `x11/` | Display, keyboard, pointer, brightness and hotplug helpers; example configs | X11 session only |
| `hyprland/` | Internal panel scale and dock mirror policy | Lua display settings |
| `reference/x11/` | Alternate combined hardware helper, shell settings and input rules | X11 implementation for comparison |
| [Power](power/README.md) | Shared 80% battery threshold helper; OpenRC/systemd/dinit boot and udev activation | Hardware exposing `charge_control_end_threshold` |

Keep device facts independent from desktop appearance. The primary X11 example mirrors at 60/120 Hz; the Hyprland example uses 60 Hz; KDE stores its own scale and modes. Choose a target policy rather than starting multiple display managers/helpers.

Device IDs, connector names, rates and panel modes need checking on the destination machine. XInput product IDs use decimal pairs; hwdb/keyd use hexadecimal USB IDs. The alternate helper reads `~/.config/x11/hardware.conf` and uses its paired input/udev rules; it is not intended to run alongside the primary X11 hotplug helper.

The current battery rules use 80%. Kernel, boot and storage configurations were not copied wholesale.

[Audio](audio/README.md) records the 2026-10-03 Intel SOF firmware/kernel lesson and the user’s later confirmation that sound works. [Keyboard](keyboard/README.md) adds the scoped duplicate-HID adapter; [power](power/README.md) adds a small dinit boundary over the shared helper. These `snapshot-08`/`collection-03` additions remain machine examples with hashes/edits in [sources.json](../docs/sources.json); no hardware activation occurred.
