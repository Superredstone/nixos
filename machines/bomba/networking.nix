{ ... }:
{
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedTCPPortRanges = [
        {
          from = 8001;
          to = 8005;
        }
      ];
      allowedUDPPorts = [
        80
        443
      ];
      enable = true;
    };
  };
}
