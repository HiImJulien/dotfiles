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

  xdg.configFile.ags = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./ags;
  };
}
