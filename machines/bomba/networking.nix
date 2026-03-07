{ ... }:
{
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        22
        5900
        8001
      ];
      allowedUDPPorts = [ ];
      enable = true;
    };
  };
}
