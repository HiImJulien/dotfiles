{ config, inputs, pkgs, self, catppuccin, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "kirsch";
    homeDirectory = "/home/kirsch";
    stateVersion = "24.11";
  };

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [
      "JetBrainsMono"
      "Iosevka"
    ];
    })
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin

    ./alacritty
    ./direnv
    ./git
    ./gtk
    ./hyprland
    ./hyprpaper
    ./nvim
    ./tmux
    ./zsh
  ];

  catppuccin = {
    enable = false;
    flavor = "mocha";
    accent = "red";

    cursors.enable = true;
  };

  xdg.enable = true;
}

