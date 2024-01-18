{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      pkgs.vimPlugins.catppuccin-nvim
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp_luasnip
      pkgs.vimPlugins.friendly-snippets
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.mason-lspconfig-nvim
      pkgs.vimPlugins.mason-nvim
      pkgs.vimPlugins.mason-tool-installer-nvim
      pkgs.vimPlugins.none-ls-nvim
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.nvim-dap
      pkgs.vimPlugins.nvim-dap-ui
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.telescope-ui-select-nvim
      pkgs.vimPlugins.vim-tmux-navigator
      pkgs.vimPlugins.yuck-vim
    ];

    extraLuaConfig = ''
      vim.g.home_manager = true

      ${builtins.readFile ./init.lua}
    '';
  };

  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
}
