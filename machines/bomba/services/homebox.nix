{ ... }:
{
  services.homebox = {
    enable = true;
    settings = {
      HBOX_WEB_PORT = "8016"; 
      HBOX_OPTIONS_ALLOW_REGISTRATION = "false";
    };
  };
}
