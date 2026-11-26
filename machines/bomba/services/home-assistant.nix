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
      http = {
        use_x_forwarded_for = true;
        trusted_proxies = [
          "127.0.0.1"
          "::1"
        ];
      };
    };
  };
}
