{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../_common
    ];

  wsl = {
    enable = true;
    defaultUser = "kirsch";
    startMenuLaunchers = true;
  };

  networking.hostName = "esterni";
  environment.systemPackages = with pkgs; [
    gcc
    foot
    git
    neovim
    nodejs_20
    wget
    zsh
    rustup
  ];

  system.stateVersion = "23.11";
}
