# Deployment rollback

Before an authorized deployment, keep a target-local record of originals, hashes, symlink targets, newly created paths, package changes and live settings. Keep those backups outside the clone. Repository provenance is not a backup of the target machine.

1. Stop using newly registered actions/services through the target's actual session/init mechanism. Removing a dinit boot link prevents future startup but does not stop an already active service. Disable only the selected battery adapter; the helper is shared with any optional udev rule.
2. Restore replaced files from backups. Remove files/symlinks created by deployment only when their current content/target still matches the recorded deployment and no later work depends on them. Include per-user D-Bus overrides, KWin packages, cursor aliases, toolbar/profile choices and Firefox policy paths.
3. Undo the selected keyboard remapping layer and rebuild/reinitialize its hardware database as appropriate. Removing an indexed helper/rule does not restore an already remapped kernel keymap; restore the original mapping or replug into the restored rules. Never apply a global reverse swap to compensate.
4. Restore service boot links, live input/effect/profile settings and any GTK settings-service values separately from file restoration. A file change may need a targeted reload or fresh application/session; saved files do not reset already running objects.
5. If policy protection was added, review and restore only its exact pacman `NoUpgrade` entry. Preserve unrelated pacman changes and handle pending `.pacnew` policy files deliberately. A removed `user.js` preference can remain in generated Firefox settings; explicitly reset adopted preferences in the target profile if rollback requires it.
6. Review dependencies before package removal. Do not remove firmware, decoders or fonts used by other software just because this deployment installed them. Schedule reboot/greeter/session actions with the user when needed; retain recovery access for SDDM changes.
7. Repeat the relevant [behavior checks](validation.md). State which features were restored live and which await a new session/boot.

Captured deployment reports can contain abandoned or stalled scripts. Read final evidence first rather than replaying every script. Do not claim authentication, microphone, battery boot persistence or keyboard hotplug persistence from an unrelated successful test.
