# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../_common
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "niernen-1";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80  # Required for http
        443 # Required for https
      ];

      allowedUDPPorts = [
        80  # Required for http3
        443
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  users.users.kirsch = {
    openssh.authorizedKeys.keyFiles = [ inputs.ssh-ids.outPath ];
  };

  services.openssh = {
  	enable = true;

    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  system.stateVersion = "23.11";
}

