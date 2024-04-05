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

  virtualisation = {
    docker = {
      enable = true;
      rootless.enable = true;
      rootless.setSocketVariable = true;
    };
  };

  networking.hostName = "esterni";
  environment.systemPackages = with pkgs; [
    foot
    git
    neovim
    nodejs_20
    wget
    zsh
  ];

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
  };

  users.users.kirsch = {
    description = "Julian Kirsch";
    extraGroups = ["wheel" "docker"];
    home = "/home/kirsch";
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.11";
}
