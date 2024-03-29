{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      cmp-nvim-lsp
      cmp_luasnip
      friendly-snippets
      lualine-nvim
      luasnip
      mason-lspconfig-nvim
      mason-nvim
      mason-tool-installer-nvim
      noice-nvim
      none-ls-nvim
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      plenary-nvim
      telescope-file-browser-nvim
      telescope-nvim
      telescope-ui-select-nvim
      vim-tmux-navigator
      yuck-vim
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
