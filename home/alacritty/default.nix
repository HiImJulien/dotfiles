{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [
          "-c"
          "tmux new-session -A -s main"
        ];
      };
    };
  };

}
