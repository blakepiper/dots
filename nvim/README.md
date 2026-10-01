# Neovim

`config/` is the current machine's complete `~/.config/nvim/`, including the plugin lock and minimal color scheme. `bin/nvimide` is the current `~/.local/bin/nvimide` launcher. `config/SOURCE.txt` records the capture and dependency choices. Mason manages language server/formatter dependencies; unused LuaRocks integration is disabled.

The launcher optionally changes into its first directory argument, sets `NVIM_IDE=1`, and passes remaining arguments to Neovim. IDE mode opens a 30-column explorer on the left and two stacked terminals on the right at about 40% of screen width. The second terminal runs `neofetch`; its config lives under `../terminal/neofetch/`. Plain `nvim` does not request that layout.

Inspect `config/lua/config/lazy.lua` for bootstrap behavior and `config/lua/config/ide.lua` for layout logic. This module expects Neovim compatible with its LazyVim snapshot, Git, plugin dependencies, and optionally Nerd Fonts/neofetch. Plugin downloads and actual editor startup were not performed as part of collection.

Updated 2026-10-01: IDE startup reuses an existing Snacks explorer, opens terminals after its initial search finishes, and queues overlapping explorer refreshes until both finder and matcher finish. This prevents duplicate folder entries with the captured Snacks version. The fix was confirmed by the user in the local interactive session; no additional validation, tests or CI were run or added when copying it into the collection.
