{ ... }:
let
  dockerNetwork = "172.18.0.0/16";
in
{
  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [
        80
        443
      ];
      extraInputRules = ''
        ip saddr ${dockerNetwork} tcp dport 5900 accept
        ip saddr ${dockerNetwork} tcp dport 8001-8005 accept
      '';
    };
  };
}
