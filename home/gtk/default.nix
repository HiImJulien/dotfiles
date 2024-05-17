{ config, inputs, pkgs, self, ... }:

{
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      size = "compact";
      tweaks = [ "normal" ];
    };
  };
}
