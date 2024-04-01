{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "alacritty";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = "set -g @catppuccin_flavour 'mocha'";
      }
      sensible
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -ga terminal-overrides ",alacritty:Tc"
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set -g mouse on
    '';

  };
}

