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
      lsp_lines-nvim
      luasnip
      noice-nvim
      none-ls-nvim
      none-ls-nvim
      nvim-cmp
      nvim-dbee
      nvim-lspconfig
      nvim-notify
      nvim-treesitter.withAllGrammars
      pest-vim
      plenary-nvim
      startup-nvim
      telescope-file-browser-nvim
      telescope-nvim
      telescope-ui-select-nvim
      vim-tmux-navigator
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
    extraPackages = with pkgs; [
      black
      fd
      fzf
      gopls
      lua-language-server
      nodePackages_latest."@astrojs/language-server"
      nodePackages_latest.svelte-language-server
      nodePackages_latest.typescript-language-server
      vscode-langservers-extracted
      nodePackages_latest.intelephense
      pyright
      ripgrep
      rust-analyzer
      stylua
      tailwindcss-language-server
      typstyle
      tinymist
    ];
  };

  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };

  xdg.configFile."nvim/after" = {
    source = ./after;
    recursive = true;
  };

  xdg.configFile."nvim/ftdetect" = {
    source = ./ftdetect;
    recursive = true;
  };

}
