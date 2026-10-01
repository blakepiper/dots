# Terminal preferences

Use **Bash with ble.sh in every terminal**. Install ble.sh on each adopting machine and load it from interactive Bash startup. [Shared Bash setup](../shell/bash/README.md) provides the canonical fragment, supported paths and verification steps. Terminal emulator choice does not change this preference.

`konsole/` contains the current profile, readable-blue color scheme and Konsole selection config. Profiles/colors map to `~/.local/share/konsole/`; `konsolerc` maps to `~/.config/konsolerc`. The selected font is Hack Nerd Font Mono, size 9; the command is `/bin/bash`.

`st/` contains `config.h`, the scrollback/URL patch and license for st 0.9.3 customization. These are source material, not a terminal binary or standalone source tree. The config expects `/usr/bin/st-shell`; the included wrapper expects `/usr/share/st/bashrc`, with ble.sh loaded through the shared Bash setup or its fallback. Adapt paths when building for another distribution, and keep Bash as the selected shell.

`tmux/tmux.conf` enables mouse support. The optional [Nix package selection](tmux/README.md) lives under `tmux/platform/nix/`; application settings are shared. `neofetch/config.conf` is the current config used by `nvimide`'s second terminal.

[Foot settings](foot/foot.ini) map to `~/.config/foot/foot.ini` and select Bash, JetBrainsMono Nerd Font and an opaque dark palette. [Kitty config](kitty/kitty.conf) uses JetBrainsMono Nerd Font, Seafoam Dusk colors, translucent backgrounds, and copy/paste/Shift+Enter bindings. It maps to `~/.config/kitty/kitty.conf`; its source license is preserved at [desktop/niri/LICENSE](../desktop/niri/LICENSE).
