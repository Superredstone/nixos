{ ... }:
{
  imports = [
    ./hardware.nix
    ./boot.nix
    ./nvidia.nix
    ./services.nix
    ./virtualisation.nix
    ./networking.nix
  ];

  networking.hostName = "katana"; # Define your hostname.

  system.stateVersion = "26.05";
}
