{ config, pkgs, self, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "kirsch";
    homeDirectory = "/home/kirsch";
    stateVersion = "23.11";
  };

  imports = [
    ./git
    ./nvim
  ];
}

