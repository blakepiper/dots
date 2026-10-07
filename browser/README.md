# Firefox configuration

[`firefox/chrome/userChrome.css`](firefox/chrome/userChrome.css) and [`firefox/user.js`](firefox/user.js) capture the local Firefox appearance and explicit preferences. [`firefox/policies.json`](firefox/policies.json) remains the independent enterprise policy reference. No account data, browsing data, generated profile preferences, or extension packages are included.

## Appearance and preferences

The stylesheet makes interface corners square, hides account/Sync buttons and sign-in promotions, and hides the sidebar utility strip while preserving the vertical tab strip. The collapsed sidebar is fixed at 50 CSS pixels. It also hides extra new-tab/all-tabs controls and the pinned uBlock toolbar icon, preserving the native + below vertical tabs. Outside Customize mode, it places the menu before the extensions button and accounts for toolbar overflow. It has no imports or external assets.

`user.js` enables custom stylesheets, keeps the sidebar visible, selects vertical tabs and the built-in System theme — auto, retains the local toolbar theme preference (`browser.theme.toolbar-theme = 0`), and disables Firefox's new-tab page. The built-in PDF viewer uses a dark theme and forced page colors (`#181818` background, `#eeeeee` foreground).

The reviewed local `user.js` also includes strict tracking protection, Global Privacy Control, HTTPS-Only, disabled telemetry/studies/sponsored content/search suggestions, and reduced speculative networking. Resist Fingerprinting is explicitly disabled in regular and private windows so canvas-based image uploads and pastes work. Mozilla Accounts remain enabled for the local built-in VPN use case; pairing and promotions are disabled and the CSS hides sign-in entry points. Review these behavioral choices when adapting the appearance: HTTPS-Only, WebRTC and account settings can affect websites and features.

## Destinations and dependencies

Find the target profile's **Root Directory** in `about:profiles`. Merge `user.js` into that directory and `chrome/userChrome.css` into its `chrome/` subdirectory, preserving any existing customization. The latest local source is `/home/przvl/.config/mozilla/firefox/cworvt8v.default-release`; `przvl` and the generated profile name belong to this machine and must be replaced with the target profile path. Profile locations vary by platform and package.

These files were captured with Firefox 157.0 on Linux; the original capture used Gentoo package defaults. Firefox's interface selectors, sidebar layout and internal preferences can change between versions; verify the result on the target version. The built-in System theme follows the target desktop's appearance, so desktop colors and fonts are separate dependencies. Dark Reader is an independent page-color extension; its settings are not captured here. Restart Firefox after merging the files to load the stylesheet and startup preferences. This collection does not apply them automatically.

Review `policies.json` before merging into the target distribution's enterprise policy location (the captured installation uses `/opt/firefox/distribution/policies.json`). It specifies AI blocking, tracking protection, browser defaults and forced extensions; it was not installed locally at capture time. Profile preferences reproduce some values but do not supply policy locks or forced extension installation. Host-specific interface scaling is not baked into this module.

## Source record

Snapshot `snapshot-06`, captured 2026-10-03 from the local machine; source commit unavailable (`null`). The collection base commit and full source/current hashes are recorded in [`docs/sources.json`](../docs/sources.json).

| File | Original capture edit (later updates below) | Current SHA-256 |
| --- | --- | --- |
| `firefox/chrome/userChrome.css` | Copied unchanged, including comments. | `0ee5fe0eab0df0ed92e02c780916c5c3749af34550baab28f372c46d0464a9cf` |
| `firefox/user.js` | Preserve the reviewed local file; append four appearance preferences extracted from `prefs.js`. The full generated `prefs.js` is excluded. | `6662f9dcf6411f99aea1efad89fe8824f1f329a96fd44302733bd74bca6038b8` |

Validation: the new `user.js` parses with Node and was evaluated with a stub `user_pref` to verify literal values and unique keys; source/current hashes and JSON source records were checked. The stylesheet was compared byte-for-byte with the local source. No Firefox runtime or visual check was performed and no machine settings were activated.

## Later font and policy maintenance preference

`collection-03`, 2026-10-03, adds the deployment's explicit JetBrains UI CSS and western/Unicode content font families. `browser.display.use_document_fonts=0` deliberately overrides site fonts and can change layout; this was a later preference, not part of the original `snapshot-06` capture. Install both Nerd Font families; verify the UI computed family and actual rendered page font in a restarted or separate test instance. Existing browser windows require restart.

Discover the installation-wide policy destination. The observed Artix package used `/usr/lib/firefox/distribution/policies.json` rather than the captured `/opt` path. Check `about:policies` for acceptance and verify forced extensions actually installed. If the package does not protect that file and an authorized deployment chooses pacman protection, merge the exact relative `NoUpgrade = usr/lib/firefox/distribution/policies.json` entry after backup. This creates ownership of update review: inspect `.pacnew` policies and current schema/extensions after package updates rather than assuming compatibility forever. The repo contains no pacman configuration or browser profile tree.

Report-derived changes and previous capture hashes are preserved in [sources.json](../docs/sources.json). JavaScript parsing does not establish Firefox UI or policy behavior; follow [validation](../docs/validation.md).

## Image upload compatibility preference

`snapshot-14`, 2026-10-04, sets `privacy.resistFingerprinting=false` and `privacy.resistFingerprinting.pbMode=false` in the reviewed local profile and collection `user.js`. An isolated canvas test with Firefox 157.0 returned correct data for all 1,024 sampled background pixels with Resist Fingerprinting disabled, while all 1,024 were altered with it enabled. This reproduced the image-corruption mechanism without KDE compositing. The user subsequently confirmed that the fix worked; this follow-up is recorded in `snapshot-15` on 2026-10-04.

Restart Firefox after merging these startup preferences. An `about:config` change alone would otherwise be overwritten by the previous `user.js` on restart. Strict tracking protection, Global Privacy Control and the existing extension policy remain enabled. The current local source profile is `/home/przvl/.config/mozilla/firefox/cworvt8v.default-release`; adapt the generated name and account path to the target. Only these reviewed settings were merged into the collection, preserving its other preferences. Source hashes, collection hashes and earlier captures are recorded in [sources.json](../docs/sources.json); JavaScript and JSON validation did not restart the active browser.

## Toolbar layout and swipe preferences

`snapshot-18`, 2026-10-07, captures the local toolbar/button CSS and six startup preferences from Firefox 157.0: three `browser.uiCustomization` values for the saved vertical-tab toolbar layout, plus the swipe tracker and left/right history gestures. The CSS variables and toolbar comment use functional Firefox names in the collection; behavior matches the local source.

Review the serialized toolbar layout's widget and extension IDs against the target Firefox version and installed extensions. Its navbar ends with the extensions button, which the accompanying CSS positions after the menu. The uBlock icon selector assumes the extension ID supplied by the collected policies. The saved layout is reapplied on every startup and can overwrite later toolbar customization. The swipe settings target native two-finger history navigation under X11; physical swipe behavior was not verified during this capture.

JavaScript syntax, unique literal preferences, serialized layout consistency, live/collection parity after the documented naming changes, JSON records, file hashes and Git whitespace were checked. Previous captures remain in [sources.json](../docs/sources.json). No browser restart, visual check or desktop activation was performed.
