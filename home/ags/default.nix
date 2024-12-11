{ inputs, pkgs, config, ...}:

{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;

    configDir = ../ags;

    extraPackages = with pkgs; [
      accountsservice
      dart-sass
      gobject-introspection

      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.wireplumber
    ];
  };
}
