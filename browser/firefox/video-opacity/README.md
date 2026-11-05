# Firefox video opacity

Optional extension source from `snapshot-24`, captured 2026-11-04 at commit `caa52d034a0ac04360c9776fe9d5c046f69068cb`. Source and output hashes and naming edits are in [sources.json](../../../docs/sources.json). These are reviewed source files, not a generated extension tree. No license/copyright notices were present in the selected files.

The extension prefixes a window title with `[firefox-video] ` while its active tab has a playing video. It queries embedded frames, clears the prefix after pause/tab changes, and excludes x.com and its subdomains. It does not change window opacity itself. Tab/navigation permissions and HTTP, HTTPS and file content-script matches are retained; private-window permission is not granted by this example.

`manifest.json`, `background.js` and `content.js` form the extension. `default.nix` is an optional package expression that copies those three files into an immutable package and checks JavaScript syntax. `bootstrap.js` is a Firefox AutoConfig template, kept outside that extension directory. The source name, extension ID, title marker, resource name, message types and observer name were adapted consistently to functional Firefox names.

The source uses trusted AutoConfig to load this as a built-in extension. Its Firefox package sets `general.config.sandbox_enabled=false` for AutoConfig and supplies the bootstrap as its startup configuration. This enables privileged AutoConfig APIs; it does not disable the web-content sandbox or ordinary extension signature checks. A `user.js` entry alone cannot reproduce it. For a Nixpkgs Firefox package override, the equivalent package expression is:

```nix
let
  videoOpacity = pkgs.callPackage ./default.nix { };
  manifest = builtins.fromJSON (builtins.readFile ./manifest.json);
  bootstrap = builtins.replaceStrings
    [ "@video-opacity-source@" "@video-opacity-version@" ]
    [ "${videoOpacity}/share/firefox-video-opacity" manifest.version ]
    (builtins.readFile ./bootstrap.js);
in pkgs.firefox.override {
  extraAutoConfig = ''pref("general.config.sandbox_enabled", false);'';
  extraPrefs = bootstrap;
}
```

Resolve paths relative to this directory. On other packages, adapt the distribution's AutoConfig support, replace both template placeholders, and keep the installed extension immutable and outside the profile. The extension ID is `video-opacity@firefox.local`; changing it creates a distinct extension identity. Do not load the bootstrap as a normal profile preference file.

For an existing Picom configuration using the modern `rules` syntax, merge this after any general transparency rules:

```conf
{
  match = "class_g = 'firefox' && name ^= '[firefox-video] '";
  opacity = 1.0;
  opacity-override = true;
}
```

The source's general Picom settings use 80% opacity for unfocused windows and 85% for focused windows; this exception makes playing-video Firefox windows fully opaque. This browser module does not change those desktop settings. The collected `desktop/x11` profile keeps all windows opaque, while XFCE normally uses Xfwm4's compositor, so the marker alone has no visible effect there. Choose the target compositor integration explicitly; do not run Picom alongside another compositor. KDE's collected Firefox opacity rule is independent.

JSON syntax, matching internal identifiers and normalized source parity were checked. Node was unavailable and obtaining it through Nix stalled, so JavaScript parser checks were not completed. No extension installation, Firefox restart, AutoConfig loading or compositor behavior was tested during collection maintenance.
