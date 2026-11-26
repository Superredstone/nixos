{ ... }:
{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "default_config"
      "met"
      "tplink"
      "google_translate" # default_config pulls in TTS, which needs gtts
    ];
    config = {
      default_config = { };
    };
  };
}
