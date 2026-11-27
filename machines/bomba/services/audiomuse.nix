# AudioMuse-AI: sonic analysis + playlists for Navidrome
# audiomuse_env must define NAVIDROME_USER, NAVIDROME_PASSWORD, POSTGRES_PASSWORD
{
  pkgs,
  lib,
  config,
  ...
}:
let
  net = "audiomuse_default";
  common = {
    log-driver = "journald";
    environmentFiles = [ config.sops.secrets.audiomuse_env.path ];
    environment = {
      MEDIASERVER_TYPE = "navidrome";
      NAVIDROME_URL = "http://host.containers.internal:${toString config.services.navidrome.settings.Port}";
      POSTGRES_USER = "audiomuse";
      POSTGRES_DB = "audiomusedb";
      POSTGRES_HOST = "audiomuse_postgres";
      POSTGRES_PORT = "5432";
      REDIS_URL = "redis://audiomuse_redis:6379/0";
      TEMP_DIR = "/app/temp_audio";
    };
  };
  app =
    type: extra:
    common
    // extra
    // {
      image = "ghcr.io/neptunehub/audiomuse-ai:latest";
      environment = common.environment // {
        SERVICE_TYPE = type;
      };
      volumes = [ "audiomuse_temp_${type}:/app/temp_audio" ];
      dependsOn = [
        "audiomuse_postgres"
        "audiomuse_redis"
      ];
      extraOptions = [ "--network=${net}" ];
    };
  names = [
    "audiomuse_flask"
    "audiomuse_worker"
    "audiomuse_postgres"
    "audiomuse_redis"
  ];
in
{
  virtualisation.oci-containers.backend = "podman";

  virtualisation.oci-containers.containers = {
    audiomuse_flask = app "flask" { ports = [ "8021:8000/tcp" ]; };
    audiomuse_worker = app "worker" { };
    audiomuse_postgres = common // {
      image = "docker.io/library/postgres:15-alpine";
      volumes = [ "/var/lib/audiomuse/postgres:/var/lib/postgresql/data:rw" ];
      extraOptions = [
        "--network=${net}"
        "--network-alias=audiomuse_postgres"
      ];
    };
    audiomuse_redis = {
      image = "docker.io/library/redis:7-alpine";
      log-driver = "journald";
      extraOptions = [
        "--network=${net}"
        "--network-alias=audiomuse_redis"
      ];
    };
  };

  systemd.tmpfiles.rules = [ "d /var/lib/audiomuse/postgres 0700 root root -" ];

  systemd.services =
    lib.genAttrs (map (n: "podman-${n}") names) (_: {
      serviceConfig.Restart = lib.mkOverride 90 "always";
      after = [ "podman-network-${net}.service" ];
      requires = [ "podman-network-${net}.service" ];
    })
    // {
      "podman-network-${net}" = {
        path = [ pkgs.podman ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = "podman network inspect ${net} || podman network create ${net}";
      };
    };
}
