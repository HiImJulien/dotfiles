# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../_common
    inputs.dms.nixosModules.dankMaterialShell
    inputs.dms.nixosModules.greeter
  ];

  nixpkgs = {
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "intelephense"
        "vscode"
      ];
  };

  boot = {
    loader = {
      efi.canTouchEfiVariables = false;

      grub = {
        enable = true;

        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };

    plymouth.enable = true;
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          ControllerMode = "dual";
          Experimental = true;
        };
      };
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  i18n.consoleKeyMap = "de-latin1";

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;

    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
    };

    xserver = {
      enable = true;
      xkb.layout = "de";

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
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
        };
      };
    };

    coredns = {
      enable = true;
      config = ''
        . {
          # Cloudflare and Google
          forward . 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4
          cache
        }

        local {
          template IN A  {
              answer "{{ .Name }} 0 IN A 127.0.0.1"
          }
        }
      '';
    };
  };

  networking = {
    hostName = "brisingr";
    networkmanager.enable = true;
    networkmanager.insertNameservers = ["127.0.0.1"];

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    blender
    brave
    devenv
    fd
    file
    foliate
    git
    gnome-keyring
    neovim
    niri
    openssl
    p7zip
    playerctl
    plymouth
    pulseaudio
    seahorse
    solaar
    tmux
    typst
    unzip
    vlc
    vscode
    wget
    wireplumber
    wl-clipboard
    zsh

    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  programs.niri = {
    enable = true;
  };

  programs.dankMaterialShell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    greeter = {
      compositor = {
        name = "niri";
      };

      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };

    enableSystemMonitoring = true;
    enableClipboard = true;
    enableCalendarEvents = true;

    enableVPN = false;
    enableDynamicTheming = false;
    enableAudioWavelength = false;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    logitech.wireless.enable = true;
  };

  catppuccin = {
    enable = false;
    flavor = "mocha";
    accent = "red";

    grub = {
      enable = true;
      flavor = "mocha";
    };

    plymouth = {
      enable = true;
      flavor = "mocha";
    };
  };

  system.stateVersion = "24.11";
}
