{ pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        caffeine.extensionUuid
        dash-to-dock.extensionUuid
        wallpaper-slideshow.extensionUuid
      ];
    };
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
