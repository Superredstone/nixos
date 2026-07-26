{
  config,
  ...
}:
{
  services.caddy =
    let
      authentikAuth = ''
        reverse_proxy /outpost.goauthentik.io/* http://127.0.0.1:9000

        forward_auth http://127.0.0.1:9000 {
          uri /outpost.goauthentik.io/auth/caddy
          copy_headers X-Authentik-Username X-Authentik-Groups X-Authentik-Entitlements X-Authentik-Email X-Authentik-Name X-Authentik-Uid X-Authentik-Jwt X-Authentik-Meta-Jwks X-Authentik-Meta-Outpost X-Authentik-Meta-Provider X-Authentik-Meta-App X-Authentik-Meta-Version
          trusted_proxies private_ranges
        }
      '';
    in
    {
      enable = true;
      virtualHosts = {
        "patrickcanal.it".extraConfig = ''
          root /var/www/patrickcanal.it/public
          file_server
        '';
        "vaultwarden.patrickcanal.it".extraConfig = ''
          encode zstd gzip
          reverse_proxy :8003 {
            header_up X-Real-IP {remote_host}
          }
        '';
        "gitea.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.services.gitea.settings.server.HTTP_PORT}
        '';
        "nextcloud.patrickcanal.it".extraConfig = ''
          reverse_proxy :8004
        '';
        "octoprint.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.services.octoprint.port}
        '';
        "vikunja.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.services.vikunja.port}
        '';
        "jellyfin.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.nixflix.jellyfin.network.internalHttpPort}
        '';
        "qbittorrent.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.nixflix.downloadarr.qbittorrent.port}
        '';
        "radarr.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.nixflix.radarr.settings.server.port}
        '';
        "sonarr.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.nixflix.sonarr.settings.server.port}
        '';
        "lidarr.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.nixflix.lidarr.settings.server.port}
        '';
        "prowlarr.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.nixflix.prowlarr.settings.server.port}
        '';
        "seerr.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.nixflix.seerr.port}
        '';
        "navidrome.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.services.navidrome.settings.Port}
        '';
        "yamtrack.patrickcanal.it".extraConfig = ''
          reverse_proxy :8014
        '';
        "actual.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.services.actual.settings.port}
        '';
        "inventory.patrickcanal.it".extraConfig = ''
          reverse_proxy :${toString config.services.homebox.settings.HBOX_WEB_PORT}
        '';
        "adguard.patrickcanal.it".extraConfig = ''
          ${authentikAuth}
          reverse_proxy :${toString config.services.adguardhome.port}
        '';
        "auth.patrickcanal.it".extraConfig = ''
          reverse_proxy :9000
        '';
      };
    };
}
