{
  config,
  lib,
  pkgs,
  super,
  unstable,
  ...
}: {
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
  };

  xdg.configFile."niri/dms" = {
    source = ./dms;
    recursive = true;
  };
}
