{ ... }:
{
  imports = [
    # ./nginx.nix
    ./gitea.nix
    ./nextcloud.nix
    ./ntfy.nix
    ./octoprint.nix
    ./vaultwarden.nix
  ];

  services.openssh.enable = true;
}
