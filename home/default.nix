{ config, inputs, pkgs, self, catppuccin, ... }:

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
    inputs.catppuccin.homeManagerModules.catppuccin

    ./ags
    ./alacritty
    ./git
    ./gtk
    ./hyprland
    ./nvim
    ./tmux
    ./zsh
  ];

  catppuccin = {
    enable = true;
    flavour = "mocha";
    accent = "red";
  };

  xdg.enable = true;
}

