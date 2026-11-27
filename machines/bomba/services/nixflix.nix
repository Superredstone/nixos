{ config, pkgs, ... }:
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
  lidarrPort = 8012;
  subtitleSettings = {
    subtitleDownloadLanguages = [
      "ita"
      "eng"
    ];
    saveSubtitlesWithMedia = true;
    skipSubtitlesIfEmbeddedSubtitlesPresent = true;
  };
  hostConfig = {
    username = user;
    password._secret = config.sops.secrets.nixflix_password.path;
  };
in
{
  # Intel iGPU driver for Jellyfin QSV transcoding
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  nixflix = {
    inherit mediaDir downloadsDir stateDir;
    enable = true;

    caddy = {
      enable = true;
      domain = "patrickcanal.it";
      tls.enable = true;
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
          LocalHostAuth = true;
        };
      };
    };

    recyclarr = {
      enable = true;
      radarrQuality = "1080p";
      sonarrQuality = "1080p";
      cleanupUnmanagedProfiles.enable = true;
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

    lidarr = {
      enable = true;
      config = {
        apiKey._secret = config.sops.secrets.lidarr_api_key.path;
        hostConfig = hostConfig // {
          port = lidarrPort;
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
            tags = [ "flaresolverr" ];
            username = "Petrich";
            password._secret = config.sops.secrets.indexers_ilcorsaroblu_password.path;
          }
          {
            name = "LimeTorrents";
            tags = [ "flaresolverr" ];
          }
          {
            name = "The Pirate Bay";
            tags = [ "flaresolverr" ];
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
      encoding = {
        hardwareAccelerationType = "qsv";
        qsvDevice = "/dev/dri/renderD128";
        enableTonemapping = true;
      };
      network = {
        knownProxies = [ "127.0.0.1" ];
        internalHttpPort = jellyfinPort;
      };
      users."${user}" = {
        mutable = false;
        policy.isAdministrator = true;
        password._secret = config.sops.secrets.nixflix_password.path;
      };
      # Providers that need no account
      plugins = {
        subbuzz = {
          enable = true;
          config = {
            EnableAddic7ed = true;
            EnablePodnapisiNet = true;
            EnableYifySubtitles = true;
          };
        };
        "Subtitle Extract" = {
          enable = true;
          config.ExtractionDuringLibraryScan = true;
        };
      };
      libraries = {
        Movies = subtitleSettings // {
          collectionType = "movies";
          paths = [
            "${mediaDir}/movies"
          ];
        };

        Shows = subtitleSettings // {
          collectionType = "tvshows";
          seasonZeroDisplayName = "Specials";
          paths = [
            "${mediaDir}/tv"
          ];
        };

        Music = {
          collectionType = "music";
          paths = [
            "${mediaDir}/music"
          ];
        };
      };
    };
  };
}
