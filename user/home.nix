{ config, pkgs, self, ... }:

{

  home.username = "kirsch";
  home.homeDirectory = "/home/kirsch";
  home.stateVersion = "23.11";

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = { };
  home.sessionVariables = { };

  programs.home-manager.enable = true;

  imports = [
    ./apps/alacritty.nix
    ./apps/brave.nix
    ./apps/git.nix
    ./apps/tmux.nix
    ./apps/zsh.nix

    ./apps/nvim/nvim.nix

    ./bin/amaterasu.nix
  ];
}
