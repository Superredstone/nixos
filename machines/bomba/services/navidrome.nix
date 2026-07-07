{ config, ... }:
{
  services.navidrome = {
    enable = true;
    environmentFile = config.sops.secrets.navidrome_env.path;
    settings = {
      Port = 8013;
      MusicFolder = "/var/lib/nixflix/media/music/";
      EnableSharing = true;
      ArtistArtPriority = "external, artist.*, album/artist.*";
      CoverArtPriority = "external, cover.*, folder.*, front.*, embedded";
      DiscArtPriority = "disc*.*, cd*.*, cover.*, folder.*, front.*, discsubtitle, embedded";
    };
  };
}
