# Battery charge limit

The shared `bin/battery-charge-limit` helper applies the chosen percentage to available `BAT*` charge-threshold sysfs files, skipping unchanged values. It defaults to 80 and accepts a percentage argument. The kernel and battery must expose `charge_control_end_threshold`; writes require target authorization.

Choose the activation pieces appropriate to the target, using the same helper:

- `activation/openrc/local.d/`: boot hook for OpenRC's local service.
- `activation/systemd/`: system oneshot unit for boot.
- `activation/udev/rules.d/`: device add/change hook, independent of the boot service choice.

These examples expect the helper at `/usr/local/bin/battery-charge-limit`. OpenRC's hook maps to `/etc/local.d/`, the systemd unit to `/etc/systemd/system/`, and the udev rule to `/etc/udev/rules.d/`. They all pass 80 explicitly; change that argument consistently if choosing another threshold. Use one boot mechanism; the udev hook may accompany it for device changes. No activation is performed by this collection.

Captured OpenRC/udev behavior was factored into the shared helper on 2026-10-01 and a systemd boot alternative was added. Source records retain capture hashes and edits in [sources.json](../../docs/sources.json). Validation was skipped at the user's request.
