{ config, ... }:
{
  services.navidrome = {
    enable = true;
    environmentFile = config.sops.secrets.navidrome_env.path;
    settings = {
      Port = 8013;
      MusicFolder = "/var/lib/nixflix/media/music/";
      EnableSharing = true;
    };
  };
}
