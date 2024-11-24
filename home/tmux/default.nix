{ config, lib, pkgs, fetchFromGitHub, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "alacritty";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -ogq @catppuccin_window_status_style "basic"

          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"

          set -g @catppuccin_status_left_separator "█"
        '';
      }
      sensible
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -ga terminal-overrides ",alacritty:Tc"
      set -g default-terminal "alacritty"

      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set -g mouse on

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';

  };
}

