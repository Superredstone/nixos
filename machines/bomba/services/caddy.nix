{ config, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "vaultwarden.patrickcanal.it".extraConfig = ''
          encode zstd gzip
          reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT} {
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
      "prowlarr.patrickcanal.it".extraConfig = ''
        reverse_proxy :${toString config.nixflix.prowlarr.settings.server.port}
      '';
      "seerr.patrickcanal.it".extraConfig = ''
        reverse_proxy :${toString config.nixflix.seerr.port}
      '';
    };
  };
}
