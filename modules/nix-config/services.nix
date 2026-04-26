{ pkgs, ... }:
{
  services = {
    pcscd.enable = true;
    xserver.enable = true;
    xserver.excludePackages = with pkgs; [
      xterm
    ];
    openssh = {
      enable = true;
      hostKeys = [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
    };
  };
}
