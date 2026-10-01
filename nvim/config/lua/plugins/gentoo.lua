-- Use Mason for language servers and formatters on Gentoo.
-- Lua fuzzy matching avoids requiring a Rust toolchain for completion.
return {
  {
    "saghen/blink.cmp",
    opts = { fuzzy = { implementation = "lua" } },
  },
}
