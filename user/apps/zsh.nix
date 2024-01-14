{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
