{ ... }:
{
  imports = [
    ./gitea.nix
  ];

  services.openssh.enable = true;
}
