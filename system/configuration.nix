{ config, lib, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth.enable = true;
  };

  security.polkit.enable = true;
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

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
    useXkbConfig = false; # use xkb.options in tty.
  };

  networking = {
    hostName = "amaterasu";
    networkmanager.enable = true;

    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
  };

  sound.enable = true;

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;

    xserver = {
      enable = true;
      layout = "de";

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pkgs.aerc
    pkgs.alacritty
    pkgs.brave
    pkgs.clang
    pkgs.eww-wayland
    pkgs.git
    pkgs.gnome.gdm
    pkgs.gnome.gnome-keyring
    pkgs.gnome.seahorse
    pkgs.hyprland
    pkgs.neovim
    pkgs.nodejs_21 # Can I replace this with nvm etc.?
    pkgs.nwg-panel # Remove once eww is setup
    pkgs.plymouth
    pkgs.tmux
    pkgs.unzip
    pkgs.wget
    pkgs.wl-clipboard
    pkgs.wofi # Remove once eww is setup
    pkgs.zsh
  ];

  programs = {
    hyprland.enable = true;
    zsh.enable = true;
    nix-ld.enable = true;
    ssh.startAgent = true;
  };

  users.users.kirsch = {
    isNormalUser = true;
    home = "/home/kirsch";
    description = "Julian Kirsch";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.11";

  nixpkgs.overlays = [
    (self: super: {
      brave = super.brave.override {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --password-store=gnome";
      };
    })
  ];
}

