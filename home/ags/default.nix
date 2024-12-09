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

      inputs.ags.packages.${pkgs.system}.apps
    ];
  };
}
