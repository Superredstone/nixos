{ ... }:
{
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        22
        80
        443
        8001
      ];
      allowedUDPPorts = [
        80
        443
      ];
      enable = true;
    };
  };
}
