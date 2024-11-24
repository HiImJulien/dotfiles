{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [

    # Configure brave to support Wayland and use Gnome's password store.
    (new: prev: {
      brave = prev.brave.override {
        commandLineArgs = lib.concatStrings [
          "--enable-featzres=UseOzonePlatform "
          "--ozone-platform=wayland "
          "--password-store=gnome"
        ];
      };
    })

    # Update `tmuxPlugins.catppuccin` to v2.1.1 as the current version
    # provided by nixOS seems to be broken.
    (new: prev: {
      tmuxPlugins = prev.tmuxPlugins // {
        catppuccin = prev.tmuxPlugins.catppuccin.overrideAttrs (attrs: {
          version = "v2.1.1";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "v2.1.1";
            hash = "sha256-9+SpgO2Co38I0XnEbRd7TSYamWZNjcVPw6RWJIHM+4c=";
          };
        });
      };
    })
  ];
}
