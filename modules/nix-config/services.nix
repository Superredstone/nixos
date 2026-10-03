{ pkgs, currentSystemDe, ... }:
{
  services = {
    pcscd.enable = true;
    xserver.enable = !(builtins.elem "none" currentSystemDe);
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
