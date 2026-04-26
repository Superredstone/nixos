{ pkgs, lib, ... }:
{
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
    gedit
    gnome-characters
    gnome-console
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-software
    gnome-tour
    seahorse
    simple-scan
    xterm
    yelp
  ];

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-vcs-plugin
    tumbler
  ];

  # Hack to fix "Your GStreamer installation is missing a plug-in." inside of Nautilus
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      [
        pkgs.gst_all_1.gst-plugins-good
        pkgs.gst_all_1.gst-plugins-bad
        pkgs.gst_all_1.gst-plugins-ugly
      ];
}
