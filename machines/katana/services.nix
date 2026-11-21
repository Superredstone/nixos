{ pkgs, ... }:
{
  services = {
    flatpak.enable = true;
    printing.enable = true;
    # Required for piper to work
    ratbagd.enable = true;
    journald.settings.Journal.SystemMaxUse = "500M";
    xserver.videoDrivers = [ "nvidia" ];
    udev = {
      enable = true;
      packages = with pkgs; [ via ];
    };
  };
}
