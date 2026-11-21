{ ... }:
{
  networking = {
    networkmanager.enable = true;
    wireguard.enable = true;
    firewall = {
      checkReversePath = false;
      allowedUDPPorts = [
        25565
      ];
      allowedTCPPorts = [
        25565
        8000
      ];
    };
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
