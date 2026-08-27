{ ... }:
{
  imports = [
    ./configuration.nix
    ./hardware.nix
    ./networking.nix
    ./secrets.nix
    ./services
    ./virtualisation.nix
    ./utilities.nix
  ];

  networking.hostName = "bomba";

  system.stateVersion = "26.05"; # Did you read the comment?
}
