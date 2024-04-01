{ config, lib, pkgs, ... }:

let
  theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/main/catppuccin-mocha.ini";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
in
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${theme}";
        font = "JetBrainsMono Nerd Font Mono:size=12";
      };
    };
  };
}

