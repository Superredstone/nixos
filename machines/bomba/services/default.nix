{ ... }:
{
  imports = [
    ./gitea.nix
    ./octoprint.nix
  ];

  services.openssh.enable = true;
}
