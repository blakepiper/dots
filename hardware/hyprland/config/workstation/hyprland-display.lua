-- Example panel and dock policy; adapt connector, scale and mode to the target.
-- 2880x1800 / 1.8 gives a 1600x1000 logical desktop when undocked.
return {
    internal_output = "eDP-1",
    internal_scale = 1.8,
    mirror_mode = "1920x1080@60",
}
