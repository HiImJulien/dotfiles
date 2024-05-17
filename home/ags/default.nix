{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
  };

  xdg.configFile.ags  = {
    enable = true;
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./ags;
    target = "ags";
 };
}
