{... }:
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
        lidarr_api_key = default;
        prowlarr_api_key = default;
        seerr_api_key = default;
        indexers_ilcorsaroblu_password = default;
        gitea_registration_token = default;
        navidrome_env = default;
        yamtrack_env = default;
      };
    };
}
