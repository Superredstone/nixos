{
  pkgs,
  config,
  currentSystemUser,
  ...
}:
{
  services.caddy =
    let
      basicAuth = ''
        basicauth {
          ${currentSystemUser} $2a$14$L6SBwu.0FhGBYwH2LWa6uOrBSeRHo8Lo95Vkle/g5uB7kZl7nmJPO
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
        "novnc.patrickcanal.it".extraConfig = ''
          handle {
            ${basicAuth}
            root ${pkgs.novnc}/share/webapps/novnc
            file_server browse
          }

          handle /websockify {
            ${basicAuth}
            reverse_proxy 127.0.0.1:6080
          }
        '';
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
      };
    };

  systemd.services.websockify = {
    description = "Websockify for noVNC";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Restart = "always";
      DynamicUser = true;
      ExecStart = ''
        ${pkgs.python3Packages.websockify}/bin/websockify \
          --web ${pkgs.novnc}/share/webapps/novnc \
          6080 127.0.0.1:5900
      '';
    };
  };
}
