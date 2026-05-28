{ config, ... }:
{
  sops =
    let
      default = {
        sopsFile = ../../secrets/bomba.sops.yaml;
      };
    in
    {
      secrets = {
        nextcloud_password = default // {
          owner = "nextcloud";
        };
        nixflix_password = default;
        jellyfin_api_key = default;
        qbittorrent_api_key = default;
        qbittorrent_password = default;
        radarr_api_key = default;
        sonarr_api_key = default;
        prowlarr_api_key = default;
        seerr_api_key = default;
        indexers_ilcorsaroblu_password = default;
        gitea_registration_token = default;
      };
      templates = {
        "gitea_runner.env".content = ''
          GITEA_INSTANCE_URL=${config.services.gitea.settings.server.ROOT_URL}
          GITEA_RUNNER_NAME="Runner"
          GITEA_RUNNER_REGISTRATION_TOKEN=${config.sops.placeholder.gitea_registration_token}
        '';
      };
    };
}
