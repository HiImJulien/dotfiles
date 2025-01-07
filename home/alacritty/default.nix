{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal.family = "Iosevka NFM";
        bold.family = "Iosevka NFM";
        italic.family = "Iosevka NFM";
      };

      terminal = {
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = [
            "-c"
            "tmux new-session -A -s main"
          ];
        };
      };
    };
  };

}
