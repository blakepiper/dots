// Nix installs this local extension as a trusted built-in. Signature checks
// for ordinary downloaded/profile extensions remain enabled.
try {
  const { AddonManager } = ChromeUtils.importESModule("resource://gre/modules/AddonManager.sys.mjs");
  Services.io.getProtocolHandler("resource").QueryInterface(Ci.nsIResProtocolHandler)
    .setSubstitution("firefox-video-opacity", Services.io.newURI("file://@video-opacity-source@/"));
  Services.obs.addObserver(function installFirefoxVideoOpacity() {
    Services.obs.removeObserver(installFirefoxVideoOpacity, "final-ui-startup");
    AddonManager.maybeInstallBuiltinAddon(
      "video-opacity@firefox.local", "@video-opacity-version@", "resource://firefox-video-opacity/"
    ).catch(Cu.reportError);
  }, "final-ui-startup");
} catch (error) {
  Cu.reportError(error);
}
