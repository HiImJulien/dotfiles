{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Julian Kirsch";
    userEmail = "contact@juliankirsch.me";
    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "master";

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}
