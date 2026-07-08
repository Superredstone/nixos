{ pkgs, ... }:
{
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      package = pkgs.qemu_kvm;
    };
    podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
    };
  };
}
