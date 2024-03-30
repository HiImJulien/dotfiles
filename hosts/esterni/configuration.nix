{ config, lib, pkgs, ... }:

{
  wsl = {
    enable = true;
    defaultUser = "kirsch";
    startMenuLaunchers = true;
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
  };

  networking.hostName = "esterni";
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
  ];

  system.stateVersion = "23.11"; 
}
