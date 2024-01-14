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

    plugins = with pkgs.vimPlugins; [
      pkgs.vimPlugins.catppuccin-nvim
      pkgs.vimPlugins.mason-lspconfig-nvim
      pkgs.vimPlugins.mason-nvim
      pkgs.vimPlugins.mason-tool-installer-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.vim-tmux-navigator
      pkgs.vimPlugins.yuck-vim
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
    '';
  };

  xdg.configFile.nvim = {
    source = ../nvim;
    recursive = true;
  };
}
