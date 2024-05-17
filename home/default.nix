{ config, pkgs, self, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "kirsch";
    homeDirectory = "/home/kirsch";
    stateVersion = "23.11";
  };

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  imports = [
    ./alacritty
    ./git
    ./hyprland
    ./nvim
    ./tmux
    ./zsh
  ];
}

