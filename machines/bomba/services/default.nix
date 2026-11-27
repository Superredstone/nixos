{ ... }:
{
  imports = [
    ./actual.nix
    ./adguard.nix
    ./caddy.nix
    ./cron.nix
    ./fail2ban.nix
    ./gitea.nix
    ./home-assistant.nix
    ./homebox.nix
    ./koito.nix
    ./mail.nix
    ./matrix.nix
    ./navidrome.nix
    ./nextcloud.nix
    ./nixflix.nix
    ./octoprint.nix
    ./paperless.nix
    ./patrickcanal.it.nix
    ./soularr.nix
    ./teamspeak.nix
    ./vaultwarden.nix
    ./yamtrack.nix
  ];

  services.openssh.enable = true;
}
