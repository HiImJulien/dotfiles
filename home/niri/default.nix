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
}
