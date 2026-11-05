# Optional Home Manager tool adapter; shared editor config stays under ../../config.
{ pkgs, ... }:
{
  home.packages = with pkgs; [ lua-language-server stylua shfmt ];
  xdg.configFile."nvim/lua/plugins/nix.lua".text = ''
    return {
      { "mason-org/mason.nvim", enabled = false },
      { "mason-org/mason-lspconfig.nvim", enabled = false },
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            lua_ls = {
              mason = false,
              cmd = { "${pkgs.lua-language-server}/bin/lua-language-server" },
            },
          },
        },
      },
      {
        "stevearc/conform.nvim",
        opts = {
          formatters = {
            stylua = { command = "${pkgs.stylua}/bin/stylua" },
            shfmt = { command = "${pkgs.shfmt}/bin/shfmt" },
          },
        },
      },
    }
  '';
}
