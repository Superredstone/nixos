{ config, ... }:
let
  user = "Patrick";
  baseDir = "/var/lib/nixflix";
  stateDir = "${baseDir}/state";
  downloadsDir = "${baseDir}/downloads";
  mediaDir = "${baseDir}/media";
  jellyfinPort = 8005;
  qbittorrentPort = 8006;
  radarrPort = 8007;
  prowlarrPort = 8008;
  seerrPort = 8009;
  sonarrPort = 8010;
  hostConfig = {
    username = user;
    password._secret = config.sops.secrets.nixflix_password.path;
  };
in
{
  nixflix = {
    inherit mediaDir downloadsDir stateDir;
    enable = true;

    caddy = {
      enable = true;
      domain = "patrickcanal.it";
    };

    flaresolverr.enable = true;

    torrentClients.qbittorrent = {
      enable = true;
      webuiPort = qbittorrentPort;
      password._secret = config.sops.secrets.nixflix_password.path;
      serverConfig = {
        LegalNotice.Accepted = true;
        Preferences.WebUI = {
          MaxAuthenticationFailCount = 0;
          Username = user;
          Password_PBKDF2 = "@ByteArray(8AhaCcVLo4H07+dv5uF7pQ==:m+wRuZuzus0N5mkOGXePQmDZfgTpRZiv2OSKbk1pnOA/QPa/JF4Ai1FwVbyZ1PF9odSOSI1UaRQwDMb3MxOKMg==)";
        };
      };
    };

    radarr = {
      enable = true;
      settings.server.port = radarrPort;
      config = {
        apiKey._secret = config.sops.secrets.radarr_api_key.path;
        hostConfig = hostConfig // {
          port = radarrPort;
        };
      };
    };

    sonarr = {
      enable = true;
      settings.server.port = sonarrPort;
      config = {
        apiKey._secret = config.sops.secrets.sonarr_api_key.path;
        hostConfig = hostConfig // {
          port = sonarrPort;
        };
      };
    };

    prowlarr = {
      enable = true;
      settings.server.port = prowlarrPort;
      config = {
        apiKey._secret = config.sops.secrets.prowlarr_api_key.path;
        hostConfig = hostConfig // {
          port = prowlarrPort;
        };
        indexers = [
          {
            name = "Il Corsaro Blu";
            username = "Petrich";
            password._secret = config.sops.secrets.indexers_ilcorsaroblu_password.path;
          }
        ];
      };
    };

    seerr = {
      enable = true;
      port = seerrPort;
      apiKey._secret = config.sops.secrets.seerr_api_key.path;
    };

    jellyfin = {
      enable = true;
      apiKey._secret = config.sops.secrets.jellyfin_api_key.path;
      network = {
        knownProxies = [ "127.0.0.1" ];
        internalHttpPort = jellyfinPort;
      };
      users."${user}" = {
        mutable = false;
        policy.isAdministrator = true;
        password._secret = config.sops.secrets.nixflix_password.path;
      };
      libraries = {
        Movies = {
          collectionType = "movies";
          paths = [
            "${mediaDir}/movies"
          ];
        };

        Shows = {
          collectionType = "tvshows";
          seasonZeroDisplayName = "Specials";
          paths = [
            "${mediaDir}/tv"
          ];
        };
      };
    };
  };
}
