{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Julian Kirsch";
    userEmail = "contact@juliankirsch.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
