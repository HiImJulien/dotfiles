{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.hyprpanel = {
    enable = true;

    settings = {
      bar.launcher = {
        autoDetectIcon = true;
        showIcons = true;
      };

      menus.dashboard.stats.enableGpu = false;

      theme.font = {
        name = "Jetbrains NF";
        size = "14px";
      };
    };
  };
}
