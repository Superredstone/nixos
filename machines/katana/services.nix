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

  # Keep SSH keys added to gpg-agent unlocked until logout (~400 days)
  programs.gnupg.agent.settings = {
    default-cache-ttl-ssh = 34560000;
    max-cache-ttl-ssh = 34560000;
  };
}
