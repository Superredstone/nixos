{ ... }:
{
  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        25
        53
        80
        143
        443
        465
        587
        993
        27015
      ];
      allowedUDPPorts = [
        53
        80
        443
        34197
      ];
    };
  };
}
