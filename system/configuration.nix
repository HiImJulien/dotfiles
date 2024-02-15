{ inputs, config, lib, pkgs, unstable, ... }:

let
  pythonPkgs = ps: with ps; [
    pydbus
    click
    flit
  ];
in
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
      enable = false;
      package = pkgs.pulseaudioFull;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;

      # Required to read power status
      settings = {
        General = {
          Experimental = true;
        };
      };

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

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    (python311.withPackages(pythonPkgs))
    aerc
    alacritty
    brave
    clang
    eww-wayland
    fd
    figma-agent
    figma-linux
    file
    git
    gnome.gdm
    gnome.gnome-keyring
    gnome.seahorse
    jq
    neovim
    nodejs_21 # Can I replace this with nvm etc.?
    nwg-panel # Remove once eww is setup
    openssl
    patchelf
    pkg-config
    plymouth
    rustup
    socat
    tmux
    unzip
    wget
    wireplumber
    wl-clipboard
    wofi # Remove once eww is setup
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    zsh
    poetry
    inputs.brisingr.packages.${pkgs.system}.brisingr
    mongodb-compass
  ];

  virtualisation.docker.enable = true;

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };

    zsh.enable = true;
    nix-ld.enable = true;
    ssh.startAgent = true;
  };

  users.users.kirsch = {
    isNormalUser = true;
    home = "/home/kirsch";
    description = "Julian Kirsch";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    packages = [];
    shell = pkgs.zsh;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  system.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (new: prev: {
      brave = prev.brave.override {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --password-store=gnome";
      };
    })
  ];
}

