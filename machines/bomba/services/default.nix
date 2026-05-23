{ ... }:
{
  imports = [
    ./caddy.nix
    ./gitea.nix
    ./nextcloud.nix
    ./nixflix.nix
    ./octoprint.nix
    ./teamspeak.nix
    ./vaultwarden.nix
  ];

  services.openssh.enable = true;
}
