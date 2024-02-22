{ config, lib, pkgs, ... }:

let
  wallpaper = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/6d/wallhaven-6dygpl.jpg";
    sha256 = "197ae1c8fa0b765dc49dca4b34d75526cd582f207b05dd95c72aae9db9e20b49";
  };
in
{
  xdg.configFile."hypr/hyprpaper.conf" = {
    text = ''
    preload = ${wallpaper}
    wallpaper = DP-1,${wallpaper}
    wallpaper = DP-2,${wallpaper}
    '';
  };
}
