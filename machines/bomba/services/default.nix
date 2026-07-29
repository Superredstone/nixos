{ ... }:
{
  imports = [
    ./actual.nix
    ./adguard.nix
    ./authentik.nix
    ./caddy.nix
    ./fail2ban.nix
    ./gitea.nix
    ./homebox.nix
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
