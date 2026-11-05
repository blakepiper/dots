# Terminal preferences

Use **Bash with ble.sh in every terminal**. Install ble.sh on each adopting machine and load it from interactive Bash startup. [Shared Bash setup](../shell/bash/README.md) provides the canonical fragment, supported paths and verification steps. Terminal emulator choice does not change this preference.

`konsole/` contains the current profile, readable-blue color scheme and Konsole selection config. Profiles/colors map to `~/.local/share/konsole/`; `konsolerc` maps to `~/.config/konsolerc`. The selected font is JetBrainsMono Nerd Font Mono, size 9; the command is `/bin/bash`.

`st/` contains `config.h`, the scrollback/URL patch and license for st 0.9.3 customization. These are source material, not a terminal binary or standalone source tree. The config expects `/usr/bin/st-shell`; the included wrapper expects `/usr/share/st/bashrc`, with ble.sh loaded through the shared Bash setup or its fallback. Adapt paths when building for another distribution, and keep Bash as the selected shell.

`tmux/tmux.conf` enables mouse support. The optional [Nix package selection](tmux/README.md) lives under `tmux/platform/nix/`; application settings are shared. `neofetch/config.conf` supplies the runtime-detected system display used by `nvimide`'s second terminal.

[Foot settings](foot/foot.ini) map to `~/.config/foot/foot.ini` and select Bash, JetBrainsMono Nerd Font and an opaque dark palette. [Kitty config](kitty/kitty.conf) uses JetBrainsMono Nerd Font, Seafoam Dusk colors, translucent backgrounds, and copy/paste/Shift+Enter bindings. It maps to `~/.config/kitty/kitty.conf`; its source license is preserved at [desktop/niri/LICENSE](../desktop/niri/LICENSE).

Konsole's profile was refreshed from the local machine in `snapshot-07` on 2026-10-03, with Konsole 26.04.3. That capture was unchanged; the collection-03 naming refinement retains the `/bin/bash` command, and requires the JetBrainsMono Nerd Font Mono family. No source commit is available; the source path, hashes, prior capture and collection base commit are in [sources.json](../docs/sources.json). The profile parsed as INI; no terminal settings were activated.

| Collection file (after collection-03) | SHA-256 |
| --- | --- |
| `terminal/konsole/Classic.profile` | `dad6c0c1b4051be75f94a4230e5f6af86cab891f5466f05b7deba41718efa4d5` |

## Deployment refinements

`collection-03`, 2026-10-03, renames Konsole's runtime profile/colors to `Classic`, updating dependent references together. Hidden main/session toolbar settings were already captured; they do not prove an existing session applied them. Fresh Konsole must use Classic and Mono 9 pt; see [live activation](../desktop/kde/activation.md). The earlier neofetch capture (`snapshot-08`) used a fixed Arch logo; the runtime-detected configuration below supersedes that choice. Earlier hashes remain in [sources.json](../docs/sources.json); no terminal was activated during this update.

## Neofetch

`neofetch/config.conf` maps to `~/.config/neofetch/config.conf` (or `$XDG_CONFIG_HOME/neofetch/config.conf`) and requires Bash-compatible neofetch. It keeps the preferred cyan/blue headings and palette layout, but sets `ascii_distro="auto"`: both system details and the distro ASCII symbol come from the machine running neofetch, with no fixed username, distro, CPU or memory values. The logo retains its detected distro colors; the palette helper only replaces magenta swatches with cyan.

GPU and battery fields use neofetch's runtime detectors; unsupported or absent values are omitted. Optional tools such as PCI utilities and a running graphical session affect detection. There are no source-host capability flags. Use `neofetch --config /path/to/config.conf` to inspect the example without installing it. The launcher selects the machine's `neofetch` from PATH; command-line overrides or a different user config can change its behavior.

`snapshot-25`, 2026-11-04, derives this config from reviewed source commit `caa52d034a0ac04360c9776fe9d5c046f69068cb`, replacing the fixed NixOS logo and generated GPU/battery placeholders with runtime detection, as requested. Bash syntax, ShellCheck (excluding sourced-setting unused-variable warnings), source/current hashes and a local runtime detection check passed. This verifies the available machine and implementation, not every distro's detection support. No terminal settings were activated.
