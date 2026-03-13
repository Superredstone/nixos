{ ... }:
{
  services.vaultwarden = {
    enable = true;
    domain = "vaultwarden.patrickcanal.it";
    config = {
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = 8003;
    };
  };
}
