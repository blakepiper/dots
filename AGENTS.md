# Collection conventions

- This repository is raw reference material. Keep modules usable independently and document dependencies on other modules; do not add an installer unless requested.
- Keep reusable application settings in topic directories and host/device facts under `hardware/`. Preserve upstream file layout when relative imports matter.
- For additions, record a neutral snapshot ID, capture commit where available, date, file hashes and any edits in `docs/sources.json` and the relevant README. Keep imported code/license notices intact.
- Treat captured settings as examples. Explain usernames, connector names, desktop/output IDs, package/version assumptions, and required adaptations rather than silently applying them to a machine.
- Do not collect credentials, SSH material, browser profiles, history, caches, session restores, or generated package/plugin trees. Review selected files before adding them.
- Keep preferred keybinding intent in `keybinds/README.md`; executable bindings remain with their desktop. Document differences instead of claiming exact parity.
- Validate changed JSON, shell, Lua, Python, and JavaScript where parsers are available. Record unavailable runtime checks accurately. Do not activate desktop, display-manager, or hardware changes as part of collection maintenance.

- Use application, platform or functional names in paths, runtime identifiers and prose. Do not add names or URLs of origin configuration projects; preserve required license and copyright notices.

- Keep shared application configs and helpers as single copies. Isolate session/service, power, packaging and activation alternatives at the smallest useful boundary; document their dependencies and behavior differences. Do not duplicate an entire module for a platform adapter.
