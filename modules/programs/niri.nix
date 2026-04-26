{ pkgs, lib, ... }:
{
  programs.niri.enable = true;

  services = {
    dbus.packages = [ pkgs.nautilus ];
    dbus.implementation = "broker";
    xserver.desktopManager.runXdgAutostartIfNone = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
    };
  };

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
          "gtk"
          "wlr"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };
  };

}
