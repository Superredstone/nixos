{
  pkgs,
  lib,
  currentSystemDe,
  ...
}:
let
  libDe = import ../../lib/libde.nix {
    inherit currentSystemDe lib;
  };
in
{
  services = {
    xserver.enable = true;
    xserver.excludePackages = with pkgs; [
      xterm
    ];

    # Display managers
    displayManager = {
      sddm = libDe.ifPlasma {
        enable = true;
        wayland.enable = true;
      };
      gdm.enable = libDe.ifGnome true;
    };

    # Desktop environments
    desktopManager = {
      plasma6.enable = libDe.ifPlasma true;
      gnome.enable = libDe.ifGnome true;
    };

    gnome.gnome-keyring.enable = libDe.ifGnome true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    konsole
  ];
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

  xdg = {
    autostart.enable = true;
    portal.enable = true;
  };

  programs.kdeconnect = libDe.ifNotNone {
    enable = true;
    package =
      if (currentSystemDe == "gnome") then
        pkgs.gnomeExtensions.gsconnect
      else
        pkgs.kdePackages.kdeconnect-kde;
  };

  programs.thunar.plugins =
    with pkgs.xfce;
    libDe.ifGnome [ ]
    ++ [
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
