{
  config,
  lib,
  pkgs,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = ["1w"];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  programs = {
    ssh.startAgent = true;
    zsh.enable = true;
  };

  users.users.kirsch = {
    isNormalUser = true;
    home = "/home/kirsch";
    description = "Julian Kirsch";
    extraGroups = ["wheel" "networkmanager" "docker"];
    packages = [];
    shell = pkgs.zsh;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "all"
    ];
  };

  time.timeZone = "Europe/Berlin";
}
