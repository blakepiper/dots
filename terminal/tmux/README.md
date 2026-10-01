# tmux

`tmux.conf` is the shared application config and maps to `~/.tmux.conf`. Install tmux using the target platform's package mechanism; no Nix infrastructure is required to use this config.

`platform/nix/package.nix` preserves the optional Home Manager package selection separately from application settings. It does not place `tmux.conf` and has no dependency on missing desktop modules. Relocated and clarified on 2026-10-01; capture/edit hashes are in [sources.json](../../docs/sources.json). Validation was skipped at the user's request.
