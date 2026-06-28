{ pkgs, ... }:
{
  services.navidrome = {
    enable = true;
    plugins = with pkgs.navidromePlugins; [
      discord-rich-presence
    ];
    settings = {
      Port = 8013;
      MusicFolder = "/var/lib/nixflix/media/music/";
      EnableSharing = true;
    };
  };
}
