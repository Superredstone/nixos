{ ... }:
{
  imports = [
    ./gitea.nix
    ./octoprint.nix
    ./vaultwarden.nix
  ];

  services.openssh.enable = true;
}
