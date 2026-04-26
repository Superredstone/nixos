{ pkgs, lib, config, ... }:
{
  programs.niri.enable = true;

  services.dbus.packages = [ pkgs.nautilus ];
  services.dbus.implementation = "broker";
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  services.upower.enable = true;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
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
