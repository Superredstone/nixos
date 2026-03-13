{ ... }:
{
  imports = [
    ./gitea.nix
    ./nextcloud.nix
    # ./nginx.nix
    ./octoprint.nix
    ./vaultwarden.nix
  ];

  services.openssh.enable = true;
}
