{
  config,
  pkgs,
  lib,
  unstable,
  ...
}: {
  nixpkgs.overlays = [
    (self: super: {
      neovim = unstable.neovim;
      vimPlugins = unstable.vimPlugins;
    })

    # Configure brave to support Wayland and use Gnome's password store.
    # Currently unused. Left for future reference.
    (new: prev: {
      brave = prev.brave.override {
        commandLineArgs = lib.concatStrings [
          "--enable-featzres=UseOzonePlatform "
          "--ozone-platform=wayland "
          "--password-store=gnome"
        ];
      };
    })
  ];
}
