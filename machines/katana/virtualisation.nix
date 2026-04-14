{ ... }:
{
  programs.virt-manager.enable = true;
  virtualisation = {
    docker.enable = true;
    # libvirtd.enable = true; disable temorarly because of https://github.com/NixOS/nixpkgs/issues/496836
    spiceUSBRedirection.enable = true;
  };
}
