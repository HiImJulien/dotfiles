{
  config,
  lib,
  pkgs,
  super,
  ...
}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
