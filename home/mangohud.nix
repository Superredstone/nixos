{ gamingSystem, ... }:
{
  programs.mangohud = {
    enable = gamingSystem;
    settings = {
      fps_limit = 75;
    };
  };
}
