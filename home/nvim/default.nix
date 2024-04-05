{ config, lib, pkgs, super, ... }:

let
  fromGitHub = owner: repo: rev: hash: pkgs.vimUtils.buildVimPlugin {
    name = repo;
    src = pkgs.fetchFromGitHub {
      inherit owner;
      inherit repo;
      inherit rev;
      inherit hash;
    };
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      SchemaStore-nvim
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
    extraPackages = with pkgs; [
      fd
      ripgrep
      fzf
      lua-language-server
      stylua
      nodePackages.svelte-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-json-languageserver
      rust-analyzer
      tailwindcss-language-server
    ];
  };

  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };

}
