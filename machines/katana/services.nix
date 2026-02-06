{ ... }:
{
  services = {
    flatpak.enable = true;
    printing.enable = true;
    # Required for piper to work
    ratbagd.enable = true;
    xserver.videoDrivers = [ "nvidia" ];
  };
}
