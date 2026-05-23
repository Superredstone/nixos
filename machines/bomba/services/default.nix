{ ... }:
{
  imports = [
    ./gitea.nix
    ./nextcloud.nix
    ./nginx.nix
    ./ntfy.nix
    ./octoprint.nix
    ./teamspeak.nix
    ./vaultwarden.nix
  ];

  services.openssh.enable = true;
}
