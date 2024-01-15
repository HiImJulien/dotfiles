{ config, pkgs, self, ... }:

{

  home.username = "kirsch";
  home.homeDirectory = "/home/kirsch";
  home.stateVersion = "23.11";

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # LSPs required by my lua config.
    # pkgs.biome
    # pkgs.docker-compose-language-service
    # pkgs.dockerfile-language-server-nodejs
    # pkgs.lua-language-server
    # pkgs.rust-analyzer
    # pkgs.tailwindcss-language-server
  ];

  home.file = { };
  home.sessionVariables = { };

  programs.home-manager.enable = true;

  imports = [
    ./apps/alacritty.nix
    ./apps/git.nix
    ./apps/tmux.nix
    ./apps/zsh.nix

    ./apps/nvim/nvim.nix

    ./bin/amaterasu.nix
  ];
}
