{ inputs, pkgs, config, ...}:

{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      accountsservice
    ];
  };
}
