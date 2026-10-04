# Firefox configuration

[`firefox/chrome/userChrome.css`](firefox/chrome/userChrome.css) and [`firefox/user.js`](firefox/user.js) capture the local Firefox appearance and explicit preferences. [`firefox/policies.json`](firefox/policies.json) remains the independent enterprise policy reference. No account data, browsing data, generated profile preferences, or extension packages are included.

## Appearance and preferences

The stylesheet makes interface corners square, hides account/Sync buttons and sign-in promotions, and hides the sidebar utility strip while preserving the vertical tab strip. The collapsed sidebar is fixed at 50 CSS pixels. It has no imports or external assets.

`user.js` enables custom stylesheets, keeps the sidebar visible, selects vertical tabs and the built-in System theme — auto, retains the local toolbar theme preference (`browser.theme.toolbar-theme = 0`), and disables Firefox's new-tab page. The built-in PDF viewer uses a dark theme and forced page colors (`#181818` background, `#eeeeee` foreground).

The reviewed local `user.js` also includes strict tracking protection, Global Privacy Control, fingerprint resistance, HTTPS-Only, disabled telemetry/studies/sponsored content/search suggestions, and reduced speculative networking. Mozilla Accounts remain enabled for the local built-in VPN use case; pairing and promotions are disabled and the CSS hides sign-in entry points. Review these behavioral choices when adapting the appearance: fingerprint resistance, HTTPS-Only, WebRTC and account settings can affect websites and features.

## Destinations and dependencies

Find the target profile's **Root Directory** in `about:profiles`. Merge `user.js` into that directory and `chrome/userChrome.css` into its `chrome/` subdirectory, preserving any existing customization. The captured source was `/home/przvl/.config/mozilla/firefox/uck3f97t.default-release`; `przvl` and the generated profile name belong to this machine and must be replaced with the target profile path. Profile locations vary by platform and package.

These files were captured with Firefox 157.0 on Linux using the Gentoo package defaults. Firefox's interface selectors, sidebar layout and internal preferences can change between versions; verify the result on the target version. The built-in System theme follows the target desktop's appearance, so desktop colors and fonts are separate dependencies. Dark Reader is an independent page-color extension; its settings are not captured here. Restart Firefox after merging the files to load the stylesheet and startup preferences. This collection does not apply them automatically.

Review `policies.json` before merging into the target distribution's enterprise policy location (the captured installation uses `/opt/firefox/distribution/policies.json`). It specifies AI blocking, tracking protection, browser defaults and forced extensions; it was not installed locally at capture time. Profile preferences reproduce some values but do not supply policy locks or forced extension installation. Host-specific interface scaling is not baked into this module.

## Source record

Snapshot `snapshot-06`, captured 2026-10-03 from the local machine; source commit unavailable (`null`). The collection base commit and full source/current hashes are recorded in [`docs/sources.json`](../docs/sources.json).

| File | Original capture edit (later font changes below) | Current SHA-256 |
| --- | --- | --- |
| `firefox/chrome/userChrome.css` | Copied unchanged, including comments. | `253229cc49ee5b2db74e0ade6da99c4b3ca665b937ce07c7b54edcac5a9c092f` |
| `firefox/user.js` | Preserve the reviewed local file; append four appearance preferences extracted from `prefs.js`. The full generated `prefs.js` is excluded. | `67d1276eef3f324ecc99deff297d610acdc429d2e5bb60d1761227453092857e` |

Validation: the new `user.js` parses with Node and was evaluated with a stub `user_pref` to verify literal values and unique keys; source/current hashes and JSON source records were checked. The stylesheet was compared byte-for-byte with the local source. No Firefox runtime or visual check was performed and no machine settings were activated.

## Later font and policy maintenance preference

`collection-03`, 2026-10-03, adds the deployment's explicit JetBrains UI CSS and western/Unicode content font families. `browser.display.use_document_fonts=0` deliberately overrides site fonts and can change layout; this was a later preference, not part of the original `snapshot-06` capture. Install both Nerd Font families; verify the UI computed family and actual rendered page font in a restarted or separate test instance. Existing browser windows require restart.

Discover the installation-wide policy destination. The observed Artix package used `/usr/lib/firefox/distribution/policies.json` rather than the captured `/opt` path. Check `about:policies` for acceptance and verify forced extensions actually installed. If the package does not protect that file and an authorized deployment chooses pacman protection, merge the exact relative `NoUpgrade = usr/lib/firefox/distribution/policies.json` entry after backup. This creates ownership of update review: inspect `.pacnew` policies and current schema/extensions after package updates rather than assuming compatibility forever. The repo contains no pacman configuration or browser profile tree.

Report-derived changes and previous capture hashes are preserved in [sources.json](../docs/sources.json). JavaScript parsing does not establish Firefox UI or policy behavior; follow [validation](../docs/validation.md).
