{
  config,
  lib,
  pkgs,
  super,
  unstable,
  ...
}: let
  fromGitHub = {
    owner,
    repo,
    rev,
    hash,
  }:
    unstable.vimUtils.buildVimPlugin {
      name = repo;
      src = unstable.fetchFromGitHub {
        inherit owner;
        inherit repo;
        inherit rev;
        inherit hash;
      };
    };
in {
  programs.neovim = {
    package = unstable.neovim-unwrapped;

    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with unstable.vimPlugins; [
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

      (fromGitHub {
        owner = "adibhanna";
        repo = "laravel.nvim";
        rev = "623a22de1a54bd6e96839cef1845ffaaf3a1eed1";
        hash = "sha256-2XhCGU8qTk10nBZB+ESPhfso5bsSqo9i2Nda2h+3f90=";
      })
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
    extraPackages = with unstable; [
      fd
      fzf
      lua-language-server
      nodePackages_latest."@astrojs/language-server"
      nodePackages_latest.svelte-language-server
      nodePackages_latest.typescript-language-server
      vscode-langservers-extracted
      pyright
      ripgrep
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
