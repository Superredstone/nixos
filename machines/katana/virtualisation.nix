{ ... }:
{
  programs.virt-manager.enable = true;
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    waydroid.enable = true;
  };
}
