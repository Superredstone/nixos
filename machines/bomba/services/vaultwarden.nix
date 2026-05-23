{ ... }:
{
  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://vaultwarden.patrickcanal.it";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8003;
    };
  };
}
