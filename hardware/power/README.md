# Battery charge limit

The shared `bin/battery-charge-limit` helper applies the chosen percentage to available `BAT*` charge-threshold sysfs files, skipping unchanged values. It defaults to 80 and accepts a percentage argument. The kernel and battery must expose `charge_control_end_threshold`; writes require target authorization.

Choose the activation pieces appropriate to the target, using the same helper:

- `activation/openrc/local.d/`: boot hook for OpenRC's local service.
- `activation/systemd/`: system oneshot unit for boot.
- `activation/udev/rules.d/`: device add/change hook, independent of the boot service choice.

These examples expect the helper at `/usr/local/bin/battery-charge-limit`. OpenRC's hook maps to `/etc/local.d/`, the systemd unit to `/etc/systemd/system/`, and the udev rule to `/etc/udev/rules.d/`. They all pass 80 explicitly; change that argument consistently if choosing another threshold. Use one boot mechanism; the udev hook may accompany it for device changes. No activation is performed by this collection.

Captured OpenRC/udev behavior was factored into the shared helper on 2026-10-01 and a systemd boot alternative was added. Source records retain capture hashes and edits in [sources.json](../../docs/sources.json). Validation was skipped at the user's request.

## dinit alternative

`activation/dinit/battery-charge-limit` is the small system-service adapter for dinit, sharing the existing helper. Map it to `/etc/dinit.d/battery-charge-limit`; the observed Artix deployment added a `boot.d/battery-charge-limit` link to `../battery-charge-limit`. Discover the target's boot dependency directory before linking. The scripted service depends on `udevd` and `local.target` and is ordered before `login.target`; adapt these names to the target's service graph. Use this instead of the OpenRC/systemd boot adapter, optionally alongside the shared udev rule.

When activation is separately authorized, use `dinitctl --system start battery-charge-limit` and read back the threshold; inspect with `dinitctl --system status battery-charge-limit`. Enabling boot dependencies and starting now are distinct steps. Removing a boot link does not stop an active service. The recorded deployment read back 80 while capacity was 93%; the limit prevents further charging, not active discharge. Boot persistence remains a separate check.

Snapshot `snapshot-08`, 2026-10-03: reviewed `/etc/dinit.d/battery-charge-limit`, copied unchanged, no source commit available. `collection-03` documents dependencies and behavior; hashes and report evidence are in [sources.json](../../docs/sources.json). No service or hardware setting was activated during collection maintenance.

| Added/adapted collection file | SHA-256 |
| --- | --- |
| `hardware/power/activation/dinit/battery-charge-limit` | `300d604eec69817f5d2a793af45b0ae7c5832ca9f42c1339d7b7ad391b070379` |
