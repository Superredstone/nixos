{
  pkgs,
  lib,
  config,
  currentSystemDe,
  ...
}:
let
  libDe = import ../../lib/libde.nix {
    inherit currentSystemDe lib;
  };
in
{
  programs.niri.enable = true;
  services.dbus.packages = [ pkgs.nautilus ];
  services.dbus.implementation = "broker";
  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # For god's sake, never touch this code again, so much pain has been released on the following lines.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = lib.mkForce [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      niri = {
        default = lib.mkForce [
          "wlr"
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };
  };

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

    gnome.gnome-keyring.enable = true;
  };
  environment.etc."xdg/autostart/niri.desktop".text = ''
    [Desktop Entry]
    Name=Niri
    Exec=${config.programs.niri.package}/bin/niri-session
    Type=Application
    X-GDM-SessionRegisters=true
  '';
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
