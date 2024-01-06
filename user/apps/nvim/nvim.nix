{ config, lib, pkgs, ... }:

{
  # Specify how the system interacts with neoVIm
  # Plugins are deliberately not specified here,
  # instead they're declared within the neoVIm config
  # to ensure compatibility with systems, that do not
  # support home manager.
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
    '';
  };

  xdg.configFile.nvim = {
    source = ../nvim;
    recursive = true;
  };
}
