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
    ./direnv
    ./alacritty
    ./git
    ./gtk
    ./hyprland
    ./hyprpaper
    ./nvim
    ./tmux
    ./zsh
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "red";
  };

  xdg.enable = true;
}

