{
  config,
  inputs,
  pkgs,
  self,
  catppuccin,
  ...
}: let
  cargo_home = "$HOME/.local/share/cargo";
  go_path = "$HOME/.local/share/go";
in {
  programs.home-manager.enable = true;

  home = {
    username = "kirsch";
    homeDirectory = "/home/kirsch";
    stateVersion = "24.11";
  };

  home.packages = [
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];

  home.sessionPath = [
    (cargo_home + "/bin")
  ];

  home.sessionVariables = {
    CARGO_HOME = cargo_home;
    GOPATH = go_path;
  };

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

    alacritty.enable = true;
    cursors.enable = true;
    hyprland.enable = true;
  };

  xdg.enable = true;
}
