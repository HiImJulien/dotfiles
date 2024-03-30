{ config, lib, pkgs, ... }:

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
      luasnip
      noice-nvim
      none-ls-nvim
      none-ls-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-notify
      nvim-treesitter.withAllGrammars
      plenary-nvim
      telescope-file-browser-nvim
      telescope-nvim
      telescope-ui-select-nvim
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };

  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };

  home.packages = with pkgs; [
    fzf
    lua-language-server
    stylua
    nodePackages.svelte-language-server
    nodePackages.typescript-language-server
    rust-analyzer
    tailwindcss-language-server
  ];

}
