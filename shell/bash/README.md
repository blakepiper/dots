# Bash with ble.sh

Use Bash as the shell in every terminal emulator and install ble.sh on every machine adopting this setup. ble.sh is a required part of the preferred interactive terminal experience, providing line editing, highlighting and completion.

Merge [bashrc](bashrc) into `~/.bashrc`. Keep the ble.sh section at the end, after prompt, aliases, completion and other shell initialization. Install ble.sh through the target's package manager or its own documented setup; this collection contains the startup configuration, not a vendored copy or installer.

The loader checks `BLESH_INIT` first when set, then `~/.local/share/blesh/ble.sh`, then `/usr/share/blesh/ble.sh`. Set `BLESH_INIT` to an absolute path if the target uses another location. It skips an already loaded instance and attaches only in an interactive terminal. Missing ble.sh leaves Bash usable, but means the preferred setup is incomplete.

The fragment also adds `~/.local/bin` to PATH and sets the Bash prompt in Konsole to the blue current directory followed by `$` (`#` for root), without a hostname prefix. Use the target's actual Bash executable in each emulator: the included Konsole and Kitty configs use `/bin/bash`, st uses its Bash wrapper, and the Foot config selects `/bin/bash`. The st package rcfile reads `~/.bashrc` first and has the same ble.sh path fallback.

Open a new terminal after setup and check `echo "$BASH_VERSION"` and `echo "$BLE_VERSION"`; both should have values. Noninteractive commands should remain quiet and should not load ble.sh.

`collection-03`, 2026-10-03, preserves this loader unchanged and records the deployment's verified Bash 5.3.20 and ble.sh 0.4.0-devel4+d81fd54 as observations, not pinned requirements. Build/install ble.sh intentionally; a plausible startup file without the runtime is incomplete. Use fresh interactive and quiet noninteractive checks from [validation](../../docs/validation.md). Documentation provenance is in [sources.json](../../docs/sources.json).

`snapshot-10`, 2026-10-03, captures the user-confirmed removal of the hostname from the Konsole Bash prompt. This preference belongs to Bash’s `PS1`, so it is kept in the shared [bashrc](bashrc). Merge the prompt assignment into `~/.bashrc`, then open a fresh terminal or run `source ~/.bashrc` in an existing Bash session. Shell syntax, the interactive prompt value, quiet noninteractive sourcing and manifest hashes were checked. The ble.sh loader is unchanged. Source/current hashes and prior captures are recorded in [sources.json](../../docs/sources.json); `shell/bash/bashrc` SHA-256: `dea658aa47fc32a6154636c1e27d903d41b381ae77996dad5bd766a5b661f46b`.
