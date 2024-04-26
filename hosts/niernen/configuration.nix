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

  networking.hostName = "office-juliankirsch-me";
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

