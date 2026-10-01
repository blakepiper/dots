{ pkgs, ... }:

{
  # Optional Home Manager package selection. The shared tmux.conf is placed separately.
  home.packages = [ pkgs.tmux ];
}
