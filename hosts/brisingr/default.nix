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

  nixpkgs = {

    config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "typora"
      "intelephense"
    ];
  };

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = false;

      grub = {
        enable = true;

        device = "nodev";
        efiSupport = true;
        useOSProber = true;

        catppuccin = {
          enable = true;
          flavor = "mocha";
        };
      };
    };

    plymouth = {
      enable = true;
      catppuccin = {
        enable = true;
        flavor = "mocha";
      };
    };

    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
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
          ControllerMode = "bredr";
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

      wireplumber.extraConfig = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
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

  # Upgrade lunacy version to the latest.

  environment.systemPackages = with pkgs; [
    alacritty
    brave
    fd
    file
    firefox
    foliate
    gdm
    git
    gnome-keyring
    inputs.hyprpaper.packages.${pkgs.system}.hyprpaper
    mutter
    neovim
    nodejs_20
    openssl
    p7zip
    plymouth
    pulseaudio
    rustup
    seahorse
    tmux
    typora
    unzip
    wget
    wireplumber
    wl-clipboard
    wofi
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
    cheese
    evince
    geary
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-terminal
    gnome-weather
    totem
    yelp
    rygel
  ]);

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };


  system.stateVersion = "24.11";
}

