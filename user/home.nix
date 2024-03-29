{ config, pkgs, self, ... }:

{

  home.username = "kirsch";
  home.homeDirectory = "/home/kirsch";
  home.stateVersion = "23.11";

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = { };
  home.sessionVariables = {
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  programs.home-manager.enable = true;

  imports = [
    ./apps/alacritty.nix
    ./apps/eww.nix
    ./apps/git.nix
    ./apps/hyprland.nix
    ./apps/hyprpaper.nix
    ./apps/nvim/nvim.nix
    ./apps/tmux.nix
    ./apps/zsh.nix

    ./bin/amaterasu.nix
  ];
}
