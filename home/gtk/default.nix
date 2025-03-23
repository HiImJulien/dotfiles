{
  config,
  inputs,
  pkgs,
  self,
  ...
}: {
  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
}
