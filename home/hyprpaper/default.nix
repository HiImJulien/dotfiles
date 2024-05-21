{ inputs, pkgs, config, ...}:

let
  wallpaper = pkgs.fetchurl {
    url = "https://i.redd.it/mvev8aelh7zc1.png";
    hash = "sha256-lJjIq+3140a5OkNy/FAEOCoCcvQqOi73GWJGwR2zT9w";
  };
in
{
  imports = [
    inputs.hyprpaper.homeManagerModules.default
  ];

  services.hyprpaper = {
    enable = true;
    preloads = [
      (builtins.toString wallpaper)
    ];

    wallpapers = [
      "DP-1,${builtins.toString wallpaper}"
      "DP-2,${builtins.toString wallpaper}"
    ];

  };
}
