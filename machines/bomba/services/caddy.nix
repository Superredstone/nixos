{
  config,
  ...
}:
{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "patrickcanal.it".extraConfig = ''
        handle /.well-known/matrix/client {
          header Access-Control-Allow-Origin *
          header Content-Type application/json
          respond `{"m.homeserver":{"base_url":"https://matrix.patrickcanal.it"}}`
        }
        handle /.well-known/matrix/server {
          header Content-Type application/json
          respond `{"m.server":"matrix.patrickcanal.it:443"}`
        }
        handle {
          reverse_proxy :8011 {
            header_up Host {hostport}
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-For {header.X-Forwarded-For}
          }
        }
      '';
      "matrix.patrickcanal.it".extraConfig = ''
        reverse_proxy :8020
      '';
      "test.patrickcanal.it".extraConfig = ''
        reverse_proxy 192.168.1.126:8000
      '';
      "bubi.patrickcanal.it".extraConfig = ''
        root * /var/www/bubi
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
        reverse_proxy :8017
      '';
      "paperless.patrickcanal.it".extraConfig = ''
        reverse_proxy :8018
      '';
      "home.patrickcanal.it".extraConfig = ''
        reverse_proxy :8123
      '';
      "koito.patrickcanal.it".extraConfig = ''
        reverse_proxy :8019
      '';
    };
  };
}
