{
  pkgs,
  lib,
  currentSystemDe,
  ...
}:
{
  services = {
    xserver.enable = true;
    xserver.excludePackages = with pkgs; [
      xterm
    ];

    # Display managers
    displayManager = {
      sddm = lib.mkIf (currentSystemDe == "plasma") {
        enable = true;
        wayland.enable = true;
      };
      gdm.enable = lib.mkIf (currentSystemDe == "gnome") true;
    };

    # Desktop environments
    desktopManager = {
      plasma6.enable = lib.mkIf (currentSystemDe == "plasma") true;
      gnome.enable = lib.mkIf (currentSystemDe == "gnome") true;
    };

    gnome.gnome-keyring.enable = lib.mkIf (currentSystemDe == "gnome") true;
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

  programs.kdeconnect = lib.mkIf (currentSystemDe != "none") {
    enable = true;
    package =
      if (currentSystemDe == "gnome") then
        pkgs.gnomeExtensions.gsconnect
      else
        pkgs.kdePackages.kdeconnect-kde;
  };

  # Hack to fix "Your GStreamer installation is missing a plug-in." inside of Nautilus
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      [
        pkgs.gst_all_1.gst-plugins-good
        pkgs.gst_all_1.gst-plugins-bad
        pkgs.gst_all_1.gst-plugins-ugly
      ];
}
