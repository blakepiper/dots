-- Load before configuring the plugin. Whitelist the glass-enabled app and layer surfaces.
local configDir = os.getenv("XDG_CONFIG_HOME")
if not configDir or configDir == "" then configDir = os.getenv("HOME") .. "/.config" end
local glassPlugin = os.getenv("HYPRGLASS_PLUGIN")
if glassPlugin and glassPlugin ~= "" then hl.plugin.load(glassPlugin) end
if hl.plugin.hyprglass then
  local hg = hl.plugin.hyprglass
  hg.config({
    enabled = false,
    default_theme = "dark",
    default_preset = "desktop-glass",
    layers = { enabled = true },
  })
  hg.preset("desktop-glass", {
    inherits = "pomme",
    blur_strength = 0.7,
    edge_thickness_px = 18,
    edge_height = 24,
    refraction_strength = 0.8,
    chromatic_aberration = 0.12,
    dark = {
      tint_color = 0x10182738,
      brightness = 0.85,
      contrast = 1.05,
      saturation = 1.0,
      adaptive_dim = 0.25,
    },
  })
  -- Clearer material for the small topbar panes; keep popup glass richer.
  hg.preset("desktop-bar-glass", {
    inherits = "desktop-glass",
    blur_strength = 0.25,
    edge_thickness_px = 5,
    edge_height = 8,
    refraction_strength = 0.25,
    chromatic_aberration = 0.02,
    dark = {
      tint_color = 0x10182718,
      brightness = 1.0,
      contrast = 1.0,
      saturation = 1.0,
      adaptive_dim = 0.08,
    },
  })
  for _, namespace in ipairs({ "desktop-workspace-glass", "desktop-clock-glass", "desktop-controls-glass" }) do
    hg.layer(namespace, {
      preset = "desktop-bar-glass",
      mask_mode = "contour",
      mask_threshold = 0.05,
      mask_feather = 0.03,
    })
  end
  -- Alpha masks follow rounded cards and exclude transparent layer margins.
  for _, namespace in ipairs({ "wofi" }) do
    hg.layer(namespace, {
      preset = "desktop-glass",
      mask_mode = "contour",
      mask_threshold = 0.05,
      mask_feather = 0.03,
    })
  end
end
hl.window_rule({
  name = "desktop-settings-glass",
  match = { class = "^org[.]local[.]DesktopSettings$", title = "^Desktop Settings$" },
  tag = "+hyprglass_enabled",
  opacity = "1.0 override 1.0 override 1.0 override",
})
hl.window_rule({
  name = "desktop-settings-clear-material",
  match = { class = "^org[.]local[.]DesktopSettings$", title = "^Desktop Settings$" },
  tag = "+hyprglass_preset_desktop-bar-glass",
})
hl.window_rule({
  name = "ghostty-glass",
  match = { class = "^org[.]local[.]GhosttyGlass$" },
  tag = "+hyprglass_enabled",
  -- Ghostty supplies background alpha; preserve opaque, readable glyphs.
  opacity = "1.0 override 1.0 override 1.0 override",
})

-- New windows split toward the right or bottom, as in OXWM's dwindle layout.
hl.config({
  general = { layout = "dwindle", gaps_out = { top = 4, right = 10, bottom = 10, left = 10 } },
  decoration = {
    active_opacity = 0.85,
    inactive_opacity = 0.80,
    rounding = 10,
  },
  dwindle = { force_split = 2 },
  input = {
    natural_scroll = true,
    touchpad = { natural_scroll = true },
  },
})

hl.layer_rule({
  name = "wofi-glass",
  match = { namespace = "^wofi$" },
  blur = true,
  ignore_alpha = 0.0,
})
for _, namespace in ipairs({ "desktop-workspace-glass", "desktop-clock-glass", "desktop-controls-glass" }) do
  hl.layer_rule({
    name = namespace,
    match = { namespace = "^" .. namespace .. "$" },
    blur = true,
    ignore_alpha = 0.0,
  })
end

local displayPath = configDir .. "/workstation/hyprland-display.lua"
local displayFile = io.open(displayPath, "r")
if displayFile then
  displayFile:close()
  local display = dofile(displayPath)
  local primary = display.primary_output or display.internal_output
  if primary and primary ~= "" then
    dofile(configDir .. "/hypr/monitors.lua")(primary)
  end
end

hl.on("hyprland.start", function()
  hl.exec_cmd("workstation-hyprland-session")
end)

-- Preserve the X11 compositor exceptions for videos and Steam games.
hl.window_rule({
  name = "opaque-firefox-video",
  match = { class = "^firefox$", title = "^\\[firefox-video\\] " },
  opacity = "1.0 override 1.0 override 1.0 override",
})
hl.window_rule({
  name = "opaque-steam-games",
  match = { class = "^steam_app_.*$" },
  opacity = "1.0 override 1.0 override 1.0 override",
})

-- Familiar OXWM shortcuts.
local exec = hl.dsp.exec_cmd
local launcher = "wofi --show drun --allow-images --prompt 'Search applications'"
hl.bind("SUPER + Return", exec("workstation-hyprland-terminal"), { description = "Open Ghostty" })
hl.bind("SUPER + Space", exec(launcher), { description = "Search applications" })
hl.bind("SUPER + SHIFT + Space", exec("workstation-hyprland-control"), { description = "Open control menu" })
hl.bind("SUPER + D", exec(launcher), { description = "Search applications" })
hl.bind("SUPER + F", exec("thunar"), { description = "Open Thunar" })
hl.bind("SUPER + S", exec("desktop-settings"), { description = "Open Desktop Settings" })
hl.bind("SUPER + B", exec("firefox"), { description = "Open Firefox" })
hl.bind("SUPER + SHIFT + B", exec("firefox --private-window"), { description = "Open a private Firefox window" })
hl.bind("SUPER + Q", hl.dsp.window.close(), { description = "Close window" })
hl.bind("SUPER + SHIFT + Q", hl.dsp.exit(), { description = "Exit Hyprland" })
hl.bind("SUPER + P", hl.dsp.window.float(), { description = "Toggle floating window" })
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen(), { description = "Toggle fullscreen" })
hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "e-1" }), { description = "Focus previous numbered workspace" })
for _, pair in ipairs({ { "Left", "left" }, { "Right", "right" },
                        { "Up", "up" }, { "Down", "down" } }) do
  hl.bind("SUPER + " .. pair[1], hl.dsp.focus({ direction = pair[2] }),
    { description = "Focus window " .. pair[2] })
  hl.bind("SUPER + SHIFT + " .. pair[1], hl.dsp.window.swap({ direction = pair[2] }),
    { description = "Swap window " .. pair[2] })
end
for _, pair in ipairs({ { "Left", "-1", "previous" }, { "Right", "+1", "next" } }) do
  hl.bind("SUPER + CTRL + " .. pair[1], hl.dsp.focus({ monitor = pair[2] }),
    { description = "Focus " .. pair[3] .. " monitor" })
  hl.bind("SUPER + CTRL + SHIFT + " .. pair[1], hl.dsp.window.move({ monitor = pair[2] }),
    { description = "Move window to " .. pair[3] .. " monitor" })
end
for i = 1, 9 do
  hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = tostring(i) }),
    { description = "Focus workspace " .. i })
  hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }),
    { description = "Move window to workspace " .. i })
end
hl.bind("SUPER + L", exec("loginctl lock-session"), { description = "Lock session" })
hl.bind("SUPER + SHIFT + S", exec("workstation-hyprland-screenshot"), { description = "Capture region" })
hl.bind("Print", exec("workstation-hyprland-screenshot --full"), { description = "Capture full screen" })
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { repeating = true, locked = true, description = "Raise volume" })
hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { repeating = true, locked = true, description = "Lower volume" })
hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, description = "Toggle mute" })
hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, description = "Toggle microphone mute" })
hl.bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true, description = "Play or pause media" })
hl.bind("XF86AudioNext", exec("playerctl next"), { locked = true, description = "Next track" })
hl.bind("XF86AudioPrev", exec("playerctl previous"), { locked = true, description = "Previous track" })
hl.bind("XF86MonBrightnessUp", exec("brightnessctl --class=backlight set 5%+"),
  { repeating = true, locked = true, description = "Raise display brightness" })
hl.bind("XF86MonBrightnessDown", exec("brightnessctl --class=backlight set 5%-"),
  { repeating = true, locked = true, description = "Lower display brightness" })
hl.bind("SUPER + G", exec("command -v steam >/dev/null && exec steam"), { description = "Open Steam" })
