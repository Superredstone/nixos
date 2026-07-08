{ ... }:
{
  imports = [
    ./caddy.nix
    ./gitea.nix
    ./navidrome.nix
    ./nextcloud.nix
    ./nixflix.nix
    ./octoprint.nix
    ./teamspeak.nix
    ./vaultwarden.nix
    ./vikunja.nix
    ./yamtrack.nix
  ];

  services.openssh.enable = true;
}
