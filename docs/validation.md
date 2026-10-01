# Collection validation — 2026-10-01

The collection was checked for file integrity, local Markdown links, available syntax parsing and Git whitespace errors. Imported patch context and five exact config snapshots have narrow whitespace exceptions in `.gitattributes`.

After neutralizing origin-project names, all remaining files were rechecked against the updated manifest. Helper names, cache/application identifiers, Nix options and dependent paths were updated together. Platform-specific Scheme references were replaced by functional shell examples and OXWM build notes. License/copyright notices remain intact.

Lua syntax checks substitute only the Hyprland numeric placeholder in a temporary copy. Python sources are parsed without executing account or panel helpers. No runtime account state or credentials were read by those helpers.

ShellCheck, Nix, Niri and QML validation tools are unavailable. No Nix evaluation, compositor/greeter session test, plugin bootstrap, package build, target-hardware verification or machine activation was performed. Run `niri validate -c /path/to/config.kdl` on the adopting machine and verify authentication/lock behavior there.

Shared terminal setup: Bash rcfiles pass `bash -n`; sourcing the common fragment noninteractively produces no output. Documentation links and capture hashes pass. Foot explicitly selects the packaged Bash executable; Nix evaluation remains unavailable.

Subsequent desktop/shell reorganization and standalone Hyprland conversion on 2026-10-01 were not validated, at the user's request. The checks above describe the earlier collection only.

The later platform-boundary refactor, including new portable session/Awake adapters and battery activation alternatives, was also not validated at the user's request.
