{ ... }:
{
  services.navidrome = {
    enable = true;
    settings = {
      Port = 8013;
      MusicFolder = "/var/lib/nixflix/media/music/";
    };
  };
}
