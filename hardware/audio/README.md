# Intel SOF audio deployment evidence

Snapshot `snapshot-08`, 2026-10-03, derives from the reviewed local deployment report and the user's follow-up. No audio configuration, boot logs, firmware binaries or modprobe override is imported. Full report hash and collection adaptation are in [sources.json](../../docs/sources.json).

The ASUS Zenbook S 14 UX5406SA (Intel Core Ultra 7 258V) on Artix Plasma Wayland/dinit initially had no ALSA cards and PipeWire Dummy Output. The running kernel was 7.1.8-artix1-3 while 7.2.8.artix1-2 and its headers were installed; old modules were unavailable. Boot logs requested:

```text
intel/sof-ipc4/lnl/sof-lnl.ri
intel/sof-ipc4-tplg/sof-lnl-cs42l43-l0-cs35l56-l23-2ch.tplg
```

Installing `sof-firmware` 2025.12.2-1 made those files readable and successfully rebuilt the installed kernel's initramfs. `alsa-utils` 1.2.16-1 supplied diagnostics. A driver/SoundWire fault made live recovery unreliable; the original report left audible sound awaiting reboot. The user subsequently confirmed **audio works now** on 2026-10-03. This supersedes the report's unresolved audio status; microphone and every optional output route were not separately confirmed.

This is a hardware dependency lesson, not an instruction to force a legacy driver or replace init. Discover the target controller, kernel/modules, firmware and topology first. Then inspect ALSA cards, PipeWire/WirePlumber devices/routes and physical playback as described in [validation](../../docs/validation.md). Package names and the observed kernel version must be checked on the next target. No hardware settings were activated by this collection update.
