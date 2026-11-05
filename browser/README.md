# Firefox configuration

[`firefox/user.js`](firefox/user.js), [`firefox/chrome/userChrome.css`](firefox/chrome/userChrome.css) and [`firefox/policies.json`](firefox/policies.json) reflect the preferred declarative Firefox setup reviewed on 2026-11-04. The optional [video-opacity extension](firefox/video-opacity/README.md) preserves its custom integration separately. No accounts, browsing data, generated profile preferences, installed extension trees or session restores are included.

## Appearance and preferences

The stylesheet makes interface corners square, hides account/Sync entry points and sidebar utility controls, and keeps a 50-pixel collapsed vertical tab strip. It hides extra new-tab/all-tabs controls and the pinned uBlock icon while preserving the native + below vertical tabs. It places the menu before the extensions button with toolbar-overflow handling. CSS behavior already matched the reviewed source; functional Firefox variable names are retained.

`user.js` enables custom stylesheets, vertical tabs and the always-visible sidebar; disables the new-tab page; selects the **Black by XI** theme; and renders PDFs with a dark viewer and forced page colors (`#181818` background, `#eeeeee` foreground). JetBrainsMono Nerd Font and JetBrainsMono Nerd Font Mono override browser and document fonts, which can change page layout. Install those fonts separately.

The preferences retain strict tracking protection, Global Privacy Control, HTTPS-Only, disabled telemetry/studies/sponsored content/search suggestions and reduced speculative networking. Resist Fingerprinting stays disabled in regular and private windows for canvas-based upload/paste compatibility. Mozilla Accounts stay enabled for the built-in VPN use case, while pairing, promotions and visible sign-in entry points are disabled. The policy locks `browser.ipProtection.enabled=true`; actual feature availability still depends on Firefox and the account/service.

The saved toolbar layout includes `ipprotection-button` and the extension area. The source generates three `browser.uiCustomization` values through its profile module; this collection serializes those same values into `user.js`. Review widget/extension IDs against the target version. These startup preferences can overwrite later toolbar customization. X11 left/right touchpad history gestures are retained; phone-only horizontal-wheel overrides are excluded from this shared workstation example.

## Policies and extension integration

`policies.json` now matches the reviewed source exactly. It blocks AI features, enables strict tracking protection, chooses DuckDuckGo for normal/private search, suppresses sponsored suggestions/content and enables Global Privacy Control. It normally installs Black by XI 3.0.2 and force-installs Dark Reader, Enhancer for YouTube and uBlock Origin, allowing the latter three in private browsing. Theme selection in `user.js` depends on the policy-installed theme; Dark Reader's own settings are not captured.

The source additionally packages a custom video-opacity extension and loads it through trusted Firefox AutoConfig. The [extension README](firefox/video-opacity/README.md) explains its package template, privileged loading, adapted identifiers and compositor dependency. Plain profile files and enterprise policies alone do not load it. Its marker requests full opacity during active-tab video playback through a separate Picom rule; it does not implement transparency or change XFCE/KDE settings by itself.

## Destinations and adaptation

Find the target profile's **Root Directory** in `about:profiles`. Merge `user.js` there and `chrome/userChrome.css` into its `chrome/` subdirectory. Restart Firefox to load startup preferences and CSS. Profile paths and usernames belong to the destination machine; no generated profile directory is assumed here.

Merge `policies.json` into the Firefox package's enterprise policy location, or use its platform policy module. Historical packages used `/opt/firefox/distribution/policies.json` or `/usr/lib/firefox/distribution/policies.json`; discover the actual destination and check `about:policies`. The reviewed source supplies these policies through Home Manager rather than copying a file into a running profile. Preserve distribution ownership and review policy/extension changes after package updates.

Earlier local captures used Firefox 157.0; the current source uses its pinned Nixpkgs Firefox package, not an independently verified runtime version. Internal preferences, UI selectors and AutoConfig APIs are version-sensitive. Adapt packages and session integration separately; these examples do not install or activate anything.

## Source and validation

`snapshot-24`, 2026-11-04, refreshes this module from reviewed Firefox configuration at commit `caa52d034a0ac04360c9776fe9d5c046f69068cb`. It supersedes the System-theme and independent-policy descriptions from the earlier local capture. Privacy/font/swipe values and normalized CSS already matched; changes are the Black theme, DuckDuckGo, VPN policy/button, generated toolbar state and custom extension source/integration notes.

[Source records](../docs/sources.json) retain original input hashes, current hashes, previous captures and edits. The base preferences and policies are copied from reviewed source; generated toolbar values are flattened into plain `user.js`. CSS is unchanged. Extension runtime identifiers are renamed consistently to application/function names, and the optional package expression uses the local source directory. No imported license/copyright notices were removed.

Unique literal preferences, serialized toolbar consistency, exact policy parity, normalized preference/CSS/extension parity, JSON, Nix syntax, manifest hashes and Git whitespace were checked. Node was unavailable; obtaining it through Nix stalled, so JavaScript parser checks were not completed. No Firefox restart, visual/physical swipe test, policy installation, extension loading or compositor activation was performed.
