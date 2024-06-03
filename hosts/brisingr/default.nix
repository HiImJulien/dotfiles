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

  nixpkgs.overlays = [
    (new: prev: {
      brave = prev.brave.override {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --password-store=gnome";
      };
    })
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth.enable = true;
  };

  hardware = {
    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "de";

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      desktopManager.gnome.enable = true;

      excludePackages = [
        pkgs.xterm
      ];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  networking = {
    hostName = "brisingr";
    networkmanager.enable = true;

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  security.polkit.enable = true;
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    brave
    fd
    file
    git
    gnome.gdm
    gnome.gnome-keyring
    gnome.mutter
    gnome.seahorse
    neovim
    nodejs_20
    openssl
    p7zip
    plymouth
    rustup
    tmux
    unzip
    wget
    wireplumber
    wl-clipboard
    zsh
  ];

  # Debloat GNOME
  environment.gnome.excludePackages = (with pkgs; [
    epiphany
    gnome-console
    gnome-photos
    gnome-text-editor
    gnome-tour
    gnome-user-docs
    gnome.cheese
    gnome.evince
    gnome.geary
    gnome.gnome-calculator
    gnome.gnome-calendar
    gnome.gnome-characters
    gnome.gnome-clocks
    gnome.gnome-contacts
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-terminal
    gnome.gnome-weather
    gnome.totem
    gnome.yelp
  ]);

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  system.stateVersion = "23.11";
}

