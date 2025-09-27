{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.caelestia = {
    enable = true;

    systemd = {
      enable = true;
      target = "xdg-desktop-portal-hyprland.service";
    };

    settings = {
      bar.status = {
        showBattery = true;
      };

      services = {
        useFahrenheit = false;
      };

      osd = {
        enabled = true;
        enableBrightness = false;
        enableMicrophone = true;
      };

      launcher.enable = true;
    };

    cli = {
      enable = true;

      settings = {
        theme.enableGtk = true;
      };
    };
  };
}
