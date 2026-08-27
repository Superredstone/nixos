{ ... }:
{
  imports = [
    ./actual.nix
    ./adguard.nix
    ./authentik.nix
    ./caddy.nix
    ./cron.nix
    ./fail2ban.nix
    ./gitea.nix
    ./homebox.nix
    ./mail.nix
    ./navidrome.nix
    ./nextcloud.nix
    ./nixflix.nix
    ./octoprint.nix
    ./teamspeak.nix
    ./vaultwarden.nix
    ./yamtrack.nix
  ];

  services.openssh.enable = true;
}
