# OXWM source-build reference

- Upstream version: 0.13.0, commit `fc4ada9ac4ee8e34ace203290a2b14d10e4671cc`.
- Source: https://codeload.github.com/tonybanters/oxwm/tar.gz/refs/tags/v0.13.0
- Tarball SHA-256: `6d0f6fbb438f21b79e6ffd77122085c18c528c4b4a90437b901d8cc3c62ab639`.
- Build inputs: Zig 0.16, Lua 5.4 source, pkg-config, libX11, libXinerama, libXft and Fontconfig.
- Apply the three files under `../patches/` in numerical order with `patch -p1` from the extracted upstream source tree.
- The captured build supplied Lua source locally and adjusted `build.zig.zon` to use it instead of fetching it during the build.
- Build command: `zig build -j2 -Doptimize=ReleaseSmall -Dcpu=baseline --prefix <output>`.
- Upstream test command: `zig build test -j2`.
- Upstream OXWM license: MIT; preserve its LICENSE when building or redistributing it.

These are build facts, not a package-manager recipe or installer. The window-manager config and patches remain independently inspectable.
