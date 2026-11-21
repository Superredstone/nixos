{ ... }:
{
  programs.virt-manager.enable = true;
  virtualisation = {
    docker.enable = true;
    # Start docker on first use via its socket instead of at boot
    docker.enableOnBoot = false;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
