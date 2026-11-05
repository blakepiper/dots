# Neovim

`config/` contains the preferred workstation Neovim configuration, including its LazyVim plugin lock, minimal black theme and IDE layout. Files match the authoritative reviewed source byte-for-byte, except collection metadata in `config/SOURCE.txt`. Plugin checkouts and generated tools are excluded.

`bin/nvimide` maps to `~/.local/bin/nvimide`. It optionally changes into its first directory argument, enables `NVIM_IDE=1` and forwards remaining arguments to Neovim. IDE mode uses a 30-column explorer on the left and two stacked terminals on the right at about 40% of screen width. The second terminal runs the executable in `NVIM_IDE_FETCH`, shell-escaped by Lua. The portable launcher defaults that variable to `neofetch` from PATH; an explicit executable path can override it (not a command with arguments). Plain `nvim` does not request this layout. If neofetch is absent, install it or select another fetch executable; no binary/package-store path is hardcoded.

Both layouts use absolute line numbers, with relative numbering disabled. IDE mode additionally wraps code. Completion uses Lua fuzzy matching, avoiding a Rust-toolchain dependency. The existing explorer refresh serialization, terminal ANSI palette (blue `#82b4ff`, bright blue `#a6c8ff`) and plugin lock are retained.

## Dependencies and tool selection

Map `config/` to `~/.config/nvim/` or the corresponding XDG config path. Install a Neovim version compatible with the captured LazyVim lock, Git, relevant C build tools, fd/fzf, tree-sitter CLI and archive utilities. Install Nerd Fonts and [neofetch settings](../terminal/README.md#neofetch) separately as desired. Neofetch detects the adopting machine's details and distro symbol at runtime.

The shared config retains Mason as the portable default for language servers and formatters; tool-specific runtimes such as Node/npm may be required. LuaRocks integration is disabled. The lockfile seeds a writable working copy under Neovim's state directory, so a read-only config can be used. Reconcile an existing state lock when adopting a new seed; copying the seed alone does not reset an existing working lock.

On NixOS, the authoritative setup instead provides Lua language server, StyLua and shfmt through packages, disables Mason and supplies their package paths. The optional Home Manager module [`platform/nix/tools.nix`](platform/nix/tools.nix) preserves only this boundary. Import it alongside your chosen shared config/launcher deployment; it does not install a duplicate editor config or launcher. Remove an existing `lua/plugins/nix.lua` when switching back to Mason, and remove the old `lua/plugins/gentoo.lua` when adopting the renamed `completion.lua`.

Phone-specific editor dimensions and terminal fonts are excluded from this workstation capture. No installer or live editor changes are included.

## Source and validation

`snapshot-25`, 2026-11-04, reviewed at commit `caa52d034a0ac04360c9776fe9d5c046f69068cb`. Updates add absolute numbering, the `NVIM_IDE_FETCH` hook, and the neutral completion filename; theme comments now match. The remaining shared source files and plugin lock already matched. The launcher replaces a source package-store fetch path with a portable PATH default; Nix tool paths stay in the optional adapter. [Source records](../docs/sources.json) retain hashes, edits and previous captures, including the completion-file rename.

Neovim parsed all Lua files without loading plugins; the options check confirmed absolute numbering. JSON, shell syntax/ShellCheck, Nix syntax, source parity, launcher argument/override behavior, runtime neofetch detection and manifest hashes were checked. ShellCheck's unused-variable warning is excluded for the sourced neofetch config because neofetch consumes those settings. No plugin downloads, Mason installs, full interactive explorer/terminal test or live settings activation was performed.
